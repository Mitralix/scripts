#!/bin/bash
#SBATCH --job-name=test_job 	#give jobs a name
#SBATCH --account=ec34		#current project that we are on
#SBATCH --nodes=1 		#number of nodes/CPU
#SBATCH --ntasks=1		#how many tasks to run simutanously
#SBATCH --time=3:00:00		#how long the job will go for
#SBATCH --mem=1G		#how much memory

## Set up job environment
set -o errexit 			# Exit script on any error
set -o nounset 		 	# Treat any unset variables as an error

FILENAME=$1

module --quiet purge 		#this resets the module environment, always good to start clean!

module load BIOS-IN5410/HT-2023

## MAke a new directory
mkdir -p $SUBMITDIR/gvcf

gatk HaplotypeCaller -R Orosv1mt.fasta \
-I $FILENAME --ploidy 1 -O gvcf/$FILENAME.gvcf.gz -ERC GVCF \
2> gvcf/HaploCaller_$FILENAME.out

echo "$FILENAME HaplotypeCalled"


echo "Finished running jobs"

