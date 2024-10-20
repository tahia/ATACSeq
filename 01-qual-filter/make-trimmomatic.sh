#!/bin/bash
# TASLIMA HAQUE
# Jan 20 2018
# make-qr-param.sh - makes parameter file for running the quality control program

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]]; then
    echo "usage: make-trimmomatic-param.sh </raw-fastq-path/> </output-path/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
PARAM="trim.param"

LOG="logs/"


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

# Check if parameter file exists. Remove it and create placeholder
#if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM


if [ ! -d $LOG ]; then 
    echo "Log directory doesn't exist. Making $LOG"
    mkdir $LOG
fi

# Loop through files
#
for fil in ${DIRS}*_R1.fastq.gz; do
    BASE=$(basename $fil)
    NAME=${BASE%_R1.fastq.gz}
    IN1="${DIRS}${NAME}_R1.fastq.gz"
    IN2="${DIRS}${NAME}_R2.fastq.gz"
    OF1="${ODIR}${NAME}_R1.fastq"
    OFS1="${ODIR}${NAME}_R1_Singleton.fastq"
    OF2="${ODIR}${NAME}_R2.fastq"
    OFS2="${ODIR}${NAME}_R2_Singleton.fastq"
    OLOG="${LOG}${NAME}.log"
    echo "java -jar /home/taslima/Tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 -threads 6 $IN1 $IN2\
    $OF1 $OFS1 $OF2 $OFS2  ILLUMINACLIP:/home/taslima/Tools/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 >> $OLOG" >> $PARAM

done
