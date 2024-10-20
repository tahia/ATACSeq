#!/bin/bash
# This will remove duplicates from sorted BAM file
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 7th Nov,2022

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
  echo "Usage: make-picard-rmdup.sh in/dir out/dir mat/dir"
  exit 1;
fi

SCRIPT="/home/taslima/Tools/picard/build/libs/picard.jar MarkDuplicates"

INDIR=$1
ODIR=$2
MAT=$3
PARAM="rmdup.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ ! -d $MAT ]; then mkdir $MAT; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

# Loop over the filtered bam files and

for fil in ${INDIR}*.bam; do
  BASE=$(basename $fil)
  NAME=${BASE%.bam}
  OUT="${ODIR}${NAME}.dedup.bam"
  MO="${MAT}${NAME}.dedup.txt"
  OLOG="${LOG}${NAME}.log"
# We can get 3/4 of memory virtually for JAVA so set memory accordingly
#A rule of thumb for reads of ~100bp is to set MAX_RECORDS_IN_RAM to be 250,000 reads per each GB given to the -Xmx parameter for SortSam
  echo "java -Xms1G -Xmx4G -jar $SCRIPT MAX_RECORDS_IN_RAM=4000000 INPUT=$fil OUTPUT=$OUT  METRICS_FILE=$MO REMOVE_DUPLICATES=true 1>$OLOG " >> $PARAM
done


Core=`wc -l rmdup.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl markdup.param 6

