#!/bin/bash
#script to reheader nuclotide busco fasta files: 

#enter the single copy working directory:
cd ~/Pulex-Pulicaria_Phylo/SAMPLE_BUSCO_augustus/run_arthropoda_odb10/busco_sequences/single_copy_busco_sequences

#move the amino acid translations to a separate folder out of the way

mkdir Amino_acids

mv *.faa Amino_acids

#Back-up the *.fna files in a directory 

mkdir Nuc_fasta

cp *.fna Nuc_fasta

#Rename the .fna files to include the sample name

ls *.fna|awk -F "." '{print$1}'|while read gene
do 
mv $gene.fna SAMPLE.$gene.fna
done

#sanity check:

ls *.fna |head

#Reheader the nucleotide fasta files:

#remove all the spaces from the old header lines:

ls *.fna|while read file; do sed -e "s/\ //g" $file > temp; mv temp $file; done

#make the new header lines
ls *.fna |awk -F "." '{print">"$1"|"$2}' > new

#make the file names 
ls *.fna > file

#make the old header lines:
grep ">" *.fna|awk -F ":" '{print$2":"$3}' > old

#make the reheader.txt file
paste -d " " old new file > reheader.txt

#apply the new headers:
cat reheader.txt |while read old new file; do sed -e "s/$old/$new/g" $file > temp; mv temp $file; done


#sanity check:

grep ">" *.fna |head

echo "Done processing SAMPLE BUSCO sequences" 


