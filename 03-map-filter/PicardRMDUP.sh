#!/bin/bash
#SBATCH -J picardmrkdup
#SBATCH -o picardmrkdup.o%j
#SBATCH -e picardmrkdup.e%j
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -p normal
#SBATCH -t 18:00:00
#SBATCH -A P.hallii_expression

module load launcher
ml picard

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="markdup.param"
 
$LAUNCHER_DIR/paramrun



echo "DONE";
date;
