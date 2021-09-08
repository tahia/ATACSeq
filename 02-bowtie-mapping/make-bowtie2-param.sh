#!/bin/bash
# TASLIMA HAQUE
# Jan 20 2018
# make-bowtie2.sh - makes parameter file for running bowtie2

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
    echo "usage: make-bowtie2-param.sh </filtered-fastq-path/> </output-path/> </reference/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
REF=$3
PARAM="bowtie2_2.param"
LOG="logs/"
SCRIPT="/home/taslima/Tools/bowtie2-2.4.4/bowtie2 "

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

# Loop through dirs for	FIL
for fil in ${DIRS}*_R1.fastq; do
    BASE=$(basename $fil)
    NAME=${BASE%_R1.fastq}
    IN1="${DIRS}${NAME}_R1.fastq"
    IN2="${DIRS}${NAME}_R2.fastq"
    OF="${ODIR}${NAME}.sam"
    OLOG="${LOG}${NAME}.log"
    echo "$SCRIPT -x $REF -1 $IN1 -2 $IN2 -X 1000 --very-sensitive --no-discordant --no-mixed -p 25 -S $OF 2>$OLOG" >> $PARAM
    #echo "$SCRIPT -x $REFF -1 $IN1 -2 $IN2 -X 1000 --very-sensitive --no-discordant --no-mixed -p 25 -S $OF 2>$OLOG" >> $PARAM
done

