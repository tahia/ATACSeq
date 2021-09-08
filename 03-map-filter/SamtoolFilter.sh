#!/bin/bash
#SBATCH -J samtoolsindex
#SBATCH -o samtoolsindex.o%j
#SBATCH -e samtoolsindex.e%j
#SBATCH -N 4
#SBATCH -n 28
#SBATCH --ntasks-per-node=7
#SBATCH -p normal
#SBATCH -t 48:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml samtools

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="filter.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
