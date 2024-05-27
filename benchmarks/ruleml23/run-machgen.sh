#!/bin/bash

BIN=../bin.m1
ENC=..
OUT=out
DIR=`pwd`
b=8
seed=87

for n in `seq 1 20`
do
  echo "=== b:$b n:$n (usc, oc=0) ==="
  pb=`printf "%02i" $b`
  pn=`printf "%02i" $n`

  $BIN/gringo -cn=$n $ENC/machgen.lp | $BIN/clasp --seed=9 | egrep 'comp' | perl -ne 's/\)/)./go; print' > tmp-random-mach.lp
  cat tmp-random-mach.lp
  
  $BIN/gringo -cb=$b -coc=1 tmp-random-mach.lp $ENC/service-cov-ocov-machgen.lp \
  | /opt/homebrew/bin/gtime -f "$b: %U" -a -o $DIR/times-cov-ocov-oc0-usc-machgen.txt \
			    clasp --opt-strat=usc --rand-freq=1 --seed=$seed | tee $OUT/cov-ocov-oc0-usc-machgen-$pb-$n.out
  
  egrep Optimization $OUT/cov-ocov-oc0-usc-machgen-$pb-$n.out | tail -1
  fgrep CPU $OUT/cov-ocov-oc0-usc-machgen-$pb-$n.out
done

