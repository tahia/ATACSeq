#!/bin/bash
# TASLIMA HAQUE
# Jan 20 2018
# make-bwa-param.sh - makes parameter file for running bwa mem

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
    echo "usage: make-bwa-param.sh </filtered-fastq-path/> </output-path/> </reference/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
REF=$3
PARAM="bwa.param"
LOG="logs/"
SCRIPT="bwa mem "

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
#if [ -e $PARAM ]; then rm $PARAM; fi
#touch $PARAM

# Loop through dirs
for fil in ${DIRS}*_R1.fastq; do
    BASE=$(basename $fil)
    NAME=${BASE%_R1.fastq*}
    IN1="${DIRS}${NAME}_R1.fastq"
    IN2="${DIRS}${NAME}_R2.fastq"
    OF="${ODIR}${NAME}.sam"
    OLOG="${LOG}${NAME}_bwa.log"
    echo "$SCRIPT  -t 8 $REF $IN1 $IN2 -o $OF 2>$OLOG" >> $PARAM
done
