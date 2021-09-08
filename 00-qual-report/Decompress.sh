#!/bin/bash
#SBATCH -J decomp
#SBATCH -o decomp.o%j
#SBATCH -e decomp.e%j
#SBATCH -N 4
#SBATCH -n 112
#SBATCH --ntasks-per-node=28
#SBATCH -p normal
#SBATCH -t 10:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml fastqc

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="bunzip.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
