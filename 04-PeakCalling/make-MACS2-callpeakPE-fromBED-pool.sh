#!/bin/bash
#  CallPeak by MACS2
# This script is for the pipe of ATAC-Seq data analysis
# Modified by Taslima Haque on 8th Nov,2022

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]] ; then
  echo "Usage: make-MACS2-callpeakPE-fromBED-pool.sh in/dir in/ctrl/path/to/bed out/dir "
  exit 1;
fi

INDIR=$1
CTRL=$2
ODIR=$3
PARAM="callpeakpool.param"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi

if [ ! -d $ODIR ]; then mkdir $ODIR; fi

if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

## Genome size including only chrs
FG=507413504
HG=484504252

#for MATCH in CF DF SF; do
for MATCH in CH DH SH; do 
       IN=""
	for fil in ${INDIR}*${MATCH}*.clean.TAG.bed; do
		IN+=" ${fil}"
	done
	OLOG="${LOG}${MATCH}_callpeak.log"
   	echo "macs2 callpeak -t $IN -c $CTRL -f BED --keep-dup all -n $MATCH --shift 73 --extsize 147 --max-gap 150 --fe-cutoff 1 \
  	--min-length 90 -g $HG --nomodel --outdir $ODIR  2> $OLOG " >> $PARAM

done




#Core=`wc -l callpeakPE.param  |cut -f1 -d ' '`

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#perl /home/taslima/Pipe/ATACSeq/03-picard-rmdup/batch_runner.pl $PARAM 10


