#!/bin/bash
# TASLIMA HAQUE
# Jan 20 2018
# make-qr-param.sh - makes parameter file for running the quality control program

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
    echo "usage: make-bowtie1-param.sh </filtered-fastq-path/> </output-path/> </reference/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
REF=$3
PARAM="bowtie1.param"
LOG="logs/"
SCRIPT="/home/taslima/Tools/bowtie-1.2.3-linux-x86_64/bowtie "

# Check if input dir exists
if [[ ! -d $DIRS ]]; then
    echo "ERROR: The input directory $DIRS doesn't exist!!!"
    exit 1;
fi

# Check if output and log dirs exist, if not make them
if [ ! -d $ODIR ]; then
    echo "Output directory doesn't exist. Making $ODIR"
    mkdir $ODIR
fi



if [ ! -d $LOG ]; then 
    echo "Log directory doesn't exist. Making $LOG"
    mkdir $LOG
fi

# Check if parameter file exists. Remove it and create placeholder
if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

# Loop through dirs
for fil in ${DIRS}*_R1.fastq; do
    BASE=$(basename $fil)
    NAME=${BASE%_R1.fastq*}
    IN1="${DIRS}${NAME}_R1.fastq"
    IN2="${DIRS}${NAME}_R2.fastq"
    OF="${ODIR}${NAME}.sam"
    OLOG="${LOG}${NAME}.log"
    #echo "$SCRIPT  $REF -1 $IN1 -2 $IN2 -X 1000 -v 3 -m 1 -p 8 --best --strata -S 1>$OF 2>$OLOG" >> $PARAM
    echo "$SCRIPT  $REF -1 $IN1 -2 $IN2 -X 1000 -n 2 -l 30 -m 1 -p 8 --best --strata -S 1>$OF 2>$OLOG" >> $PARAM
done


#Core=`wc -l bowtie1.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name

#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl bowtie1.param 4

