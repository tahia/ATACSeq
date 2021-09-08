#!/bin/bash
#SBATCH -J bowtie1
#SBATCH -o bowtie1.o%j
#SBATCH -e bowtie1.e%j
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -p normal
#SBATCH -t 12:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml bowtie/1.2.1.1

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="bowtie1-build.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
