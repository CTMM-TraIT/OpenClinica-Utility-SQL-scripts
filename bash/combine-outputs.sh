#!/bin/sh
#
# Script which combines the output of the scripts to generate an overview of diskusage with the full study name and sites.
#
sort -k1,1 -u disk-usage.log > file1.log
sort -k1,1 -u overview-studies.log > file2.log
join -o 2.2 1.2 file1.log file2.log -t '	' | sed 's/\(.\)$/\t \1/' | sort -k2 | sort -k3 > `date -I`-diskusage.txt
rm file1.log
rm file2.log
