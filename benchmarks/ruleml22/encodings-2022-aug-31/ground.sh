#!/bin/bash

BIN=../bin.m1
ENC=..
IN=in
DIR=`pwd`

for enc in cov-mixed cov-ocov cov scnt direct-cov 
do
  for oc in 0 1
  do
    if test ! -d $IN/$enc-oc$oc
    then
      mkdir -p $IN/$enc-oc$oc
    fi

    case "$oc" in
    0) e=9;;
    1) e=16;;
    esac

    for b in `seq 1 $e`
    do
      pb=`printf "%02i" $b`
      $BIN/gringo -cb=$b -coc=$oc ../service-$enc.lp > $IN/$enc-oc$oc/b$pb.sm
      gzip $IN/$enc-oc$oc/b$pb.sm
    done
  done
done
