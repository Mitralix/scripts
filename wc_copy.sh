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

module --quiet purge 		#this resets the module environment, always good to start clean!

#Usually you load a number of modules below
#module load <module name>	#this loads a specific "module" allowing you to run programs installed on the cluster

## DO SOMETHING
## Accept argument
FILENAME=$1

## Make a directory in the directory from WHERE you submitted the script. $SUBMITDIR is replaced by the location from where you submit the script
mkdir -p $SUBMITDIR/results/      #create a results directory


## Display a message
echo "Submission directory:" $SUBMITDIR #NOTE USE ECHO to make sure you know what the script is doing. 

##Display submitdir
echo "COuting lines in" $SUBMITDIR

#Copy output files to the directory yoy just set made
wc $FILENAME > $SUBMITDIR/results/wc_$FILENAME.out
## Message that you are done with the job
echo "Finished running jobs"

