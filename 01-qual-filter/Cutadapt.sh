#!/bin/bash
#SBATCH -J cutadapt
#SBATCH -o cutadapt.o%j
#SBATCH -e cutadapt.e%j
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --ntasks-per-node=28
#SBATCH -p normal
#SBATCH -t 48:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml cutadapt
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="cutadapt1.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
