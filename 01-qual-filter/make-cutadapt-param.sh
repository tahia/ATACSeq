#!/bin/bash
# TASLIMA HAQUE
# Jan 20 2018
# make-qr-param.sh - makes parameter file for running the quality control program

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]]; then
    echo "usage: make-cutadapt-param.sh </raw-fastq-path/> </output-path/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
PARAM1="cutadapt1.param"
PARAM2="cutadapt2.param"

LOG="logs/"
SCRIPT="cutadapt "

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

Round1="${ODIR}Round_1/"


if [ ! -d $Round1 ]; then
    echo "Round1 directory doesn't exist. Making $Round1"
    mkdir $Round1
fi


if [ ! -d $LOG ]; then 
    echo "Log directory doesn't exist. Making $LOG"
    mkdir $LOG
fi

# Check if parameter file exists. Remove it and create placeholder
if [ -e $PARAM1 ]; then rm $PARAM1; fi
touch $PARAM1

# Check if parameter file exists. Remove it and create placeholder
if [ -e $PARAM2 ]; then rm $PARAM2; fi
touch $PARAM2


# Loop through dirs
for fil in ${DIRS}*_1.fastq; do
    BASE=$(basename $fil)
    NAME=${BASE%_1.fastq*}
    IN1="${DIRS}${NAME}_1.fastq"
    IN2="${DIRS}${NAME}_2.fastq"
    TMP11="${Round1}${NAME}_R1.fastq"
    TMP12="${Round1}${NAME}_R2.fastq"
    OF1="${ODIR}${NAME}_R1.fastq"
    OF2="${ODIR}${NAME}_R2.fastq"
    OLOG="${LOG}${NAME}.log"
    #By Round: Round 1 NovaSeq DarkCycle & Nextera Adapter 
    echo "$SCRIPT -l 125 -a CTGTCTCTTATACACATCT -A CTGTCTCTTATACACATCT -q 30 --minimum-length 36 --pair-filter=any --nextseq-trim=20 -j 4 -o $TMP11 -p $TMP12 $IN1 $IN2 > $OLOG" >> $PARAM1
   
    #Round 2: Trim to 36 bp length    
    echo "$SCRIPT -l 50 --minimum-length 36 --pair-filter=any -j 4 -o $OF1 -p $OF2 $TMP11 $TMP12 >> $OLOG" >> $PARAM2
done
