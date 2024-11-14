#!/bin/bash
#SBATCH --job-name=test_job 	#give jobs a name
#SBATCH --account=ec34		#current project that we are on
#SBATCH --nodes=1 		#number of nodes/CPU
#SBATCH --ntasks=1		#how many tasks to run simutanously
#SBATCH --time=3:00:00		#how long the job will go for
#SBATCH --mem=4G		#how much memory

## Set up job environment
set -o errexit 			# Exit script on any error
set -o nounset 		 	# Treat any unset variables as an error

FILENAME=$1

module --quiet purge 		#this resets the module environment, always good to start clean!

module load BIOS-IN5410/HT-2023

##Create list
ls *gvcf.gz > gvcf.list

mkdir -p ${FILENAME}_DB; rm -r ${FILENAME}_DB

gatk GenomicsDBImport -V gvcf.list \
--genomicsdb-workspace-path ${FILENAME}_DB \
--intervals NC_004029.2
##run GATK genotype GVCF (3rd step)
gatk GenotypeGVCFs -R ../Orosv1mt.fasta \
-V gendb://${FILENAME}_DB -O ${FILENAME}.vcf.gz

echo "Finished running jobs"
