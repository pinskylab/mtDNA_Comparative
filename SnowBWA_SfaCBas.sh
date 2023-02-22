#!/bin/bash

#SBATCH --partition=main          # Partition (job queue)

#SBATCH --job-name=SnowBWA_CBas       # Assign an short name to your job

#SBATCH --nodes=1                 # Number of nodes you require
#SBATCH --ntasks=1                # Total # of tasks across all nodes
#SBATCH --cpus-per-task=4         # Cores per task (>1 if multithread tasks)
#SBATCH --mem=200000                # Real memory (RAM) required (MB)
#SBATCH --time=48:00:00           # Total run time limit (HH:MM:SS)

#SBATCH --output=slurm.%N.%j.out  # STDOUT output file
#SBATCH --error=slurm.%N.%j.err   # STDERR output file (optional)

cd /home/rps109/mtDNA/
touch CBas_FastqList


for fastqname in Sfa-CBas*.fq
do
	echo "$fastqname" >> CBas_FastqList.txt
done

mv CBas_FastqList.txt /scratch/rps109/BWA/CBas_FastqList.txt


cd /scratch/rps109/BWA/

module purge
module load intel/19.0.3 
module use /projects/community/modulefiles/
module load singularity/3.1.0
module load BWA/bwa-0.7.17-yc759.lua
module load samtools/1.8-gc563.lua


bwa index /home/rps109/mtDNA/Sfa_mtDNA_Ref.fasta
samtools faidx /home/rps109/mtDNA/Sfa_mtDNA_Ref.fasta
touch CBas_bam.list


cat CBas_FastqList.txt | while read name
do
	bwa mem /home/rps109/mtDNA/Sfa_mtDNA_Ref.fasta /home/rps109/mtDNA/"$name" > "$name".sam

	samtools view -bt /home/rps109/mtDNA/Sfa_mtDNA_Ref.fasta "$name".sam > "$name".bam
	samtools fixmate -O bam "$name".bam "$name".fixmate.bam 

	samtools sort -O bam -T "$name".sorted -o "$name".sorted.bam "$name".fixmate.bam

	echo "$name".sorted.bam >> CBas_bam.list
	samtools flagstat "$name".sorted.bam 
done


samtools merge Sfa_CBas.merged.bam *.sorted.bam

samtools index -b Sfa_CBas.merged.bam

exit

