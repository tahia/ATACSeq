#!/bin/bash
#SBATCH -J bwa
#SBATCH -o bwa.o%j
#SBATCH -e bwa.e%j
#SBATCH -N 7
#SBATCH -n 56
#SBATCH --ntasks-per-node=8
#SBATCH -p normal
#SBATCH -t 48:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml intel/17.0.4
ml bwa

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="bwa.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
