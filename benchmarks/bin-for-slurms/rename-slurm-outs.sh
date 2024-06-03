#!/bin/bash

# Script for renaming slurm-*.out files
# 2022/2023/2024 © Janhunen, Tomi

for f in $*
do
  if test -f $f
  then
    g=`fgrep Output: $f | awk '{print $2}'`
    d=`dirname $g`
    if test "$g" != "" -a -d "$d"
    then
      echo "Renaming $f as $g."
      mv -f $f $g
    fi
  fi
done
