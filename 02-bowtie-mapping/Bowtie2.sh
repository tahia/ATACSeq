#!/bin/bash
#SBATCH -J bowtie2
#SBATCH -o bowtie2.o%j
#SBATCH -e bowtie2.e%j
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --ntasks-per-node=2
#SBATCH -p normal
#SBATCH -t 12:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml bowtie/2.3.2

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="bowtie2.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
