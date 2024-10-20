#!/usr/bin/perl -w

use strict;
use warnings;
use Parallel::ForkManager;
use File::Slurp;

       
################################################################################################################################################################
# Author : Taslima Haque									        *
# Contact: tahiadu@gmail.com	
#This script is a batch runner.
# !!!!!!! Make sure u have at least 3 core to run it else change the $MAX_PROCESSES value!!!!!
# usage : usage: perl batch_runner.pl <dir_name>
################################################################################################################################################################

my ($fil, $MAX_PROCESSES) = @ARGV;

my $argc = $#ARGV + 1;
if ($argc < 1)
    {
    print "usage: perl batch_runner.pl <param_file> <Max_processor>\n";
    exit 1;
}

my @arr = read_file($fil, chomp => 1);
#my @arr = ("AANS01","ABHA01","AASM01","ABGW01","ABGX01","ACBS01","ABGU01","ABGZ01","ABGV01","ABGS01","ABGT01","ABGY01","ACBR01");

#my $MAX_PROCESSES = 10;


#NAME
#    Parallel::ForkManager - A simple parallel processing fork manager
#
#SYNOPSIS
#     use Parallel::ForkManager;
#
#      $pm = new Parallel::ForkManager($MAX_PROCESSES);
#
#      foreach $data (@all_data) {
        # Forks and returns the pid for the child:
#        my $pid = $pm->start and next;
#
#        ... do some work with $data in the child process ...
#
#        $pm->finish; # Terminates the child process
#      }


my $pm = new Parallel::ForkManager($MAX_PROCESSES);

foreach my $data (@arr)
	{
        # Forks and returns the pid for the child:
	my $pid = $pm->start and next;
	print "$data\n";
	system($data);

      	$pm->finish; # Terminates the child process
      }
$pm->wait_all_children;





