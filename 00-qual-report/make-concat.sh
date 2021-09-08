#!/bin/bash
# Taslima Haque
# make-qr-decompress-param.sh - makes parameter file for decompress of bz2 file

# Check for required arguments
if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]] ; then
    echo "usage: make-decompress.sh </raw-fastq-path/> </output-path/> </metafile/>"
    exit 1;
fi

# Declare variables
DIRS=$1
ODIR=$2
met=$3
PARAM="concat.param"
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

if [ ! -d $LOG ]; then 
    echo "Log directory doesn't exist. Making $LOG"
    mkdir $LOG
fi

# Check if parameter file exists. Remove it and create placeholder
if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

#Col-A2_S15_L001_R1_001.fastq
#_L00[1-2]_R[1-2]_001.fastq
while read line
do
    SAMP=`echo $line | cut -d' ' -f1`
    f1="${DIRS}*${SAMP}*R1_001.fastq"
    f2="${DIRS}*${SAMP}*R2_001.fastq"
    OFIL1="${ODIR}${SAMP}_1.fastq"
    OFIL2="${ODIR}${SAMP}_2.fastq"
    OLOG="${LOG}${SAMP}.log"
    echo "cat $f1 > $OFIL1 2> $OLOG" >>concat.param
    echo "cat $f2 > $OFIL2 2> $OLOG" >>concat.param
done < $met

# Now count the line number of the file and copy will not take more that one hr
#Core=`wc -l concat.param |cut -f1 -d ' '`
#if (( $Core % 28 == 0)); then Node="$(($Core/28))";
#        else  Node="$((($Core/28)+1))";
#fi

## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#sbatch -J concat -N $Node -n $Core -p normal -t 06:00:00 slurm.sh concat.param
#perl /home/taslima/Pipe/ATACSeq/00-qual-report/batch_runner.pl concat.param 28
