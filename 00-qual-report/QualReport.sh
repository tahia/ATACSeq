#!/bin/bash
#SBATCH -J fastqc
#SBATCH -o fastqc.o%j
#SBATCH -e fastqc.e%j
#SBATCH -N 7
#SBATCH -n 56
#SBATCH --ntasks-per-node=8
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml fastqc

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="Qual-File.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
