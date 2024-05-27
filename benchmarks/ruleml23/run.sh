#!/bin/bash

BIN=../bin
ENC=..
OUT=out
DIR=`pwd`

for b in `seq 1 9`
do
  echo "=== $b (usc, oc=0) ==="
  pb=`printf "%02i" $b`

  $BIN/gringo -cb=$b -coc=0 $ENC/service-cov-ocov.lp \
  | /usr/bin/time -f "$b: %U" -a -o $DIR/times-cov-ocov-oc0-usc.txt \
    clasp --opt-strat=usc > $OUT/cov-ocov-oc0-usc-$pb.out

  egrep Optimization $OUT/cov-ocov-oc0-usc-$pb.out | tail -1
  fgrep CPU $OUT/cov-ocov-oc0-usc-$pb.out
done

for b in `seq 1 9`
do
  echo "=== $b (bb, oc=0) ==="
  pb=`printf "%02i" $b`

  $BIN/gringo -cb=$b -coc=0 $ENC/service-cov-ocov.lp \
  | /usr/bin/time -f "$b: %U" -a -o $DIR/times-cov-ocov-oc0-bb.txt \
    clasp --opt-strat=bb > $OUT/cov-ocov-oc0-bb-$pb.out

  egrep Optimization $OUT/cov-ocov-oc0-bb-$pb.out | tail -1
  fgrep CPU $OUT/cov-ocov-oc0-bb-$pb.out
done

for b in `seq 1 15`
do
  echo "=== $b (usc, oc=1) ==="
  pb=`printf "%02i" $b`

  $BIN/gringo -cb=$b -coc=1 $ENC/service-cov-ocov.lp \
  | /usr/bin/time -f "$b: %U" -a -o $DIR/times-cov-ocov-oc1-usc.txt \
    clasp --opt-strat=usc > $OUT/cov-ocov-oc1-usc-$pb.out

  egrep Optimization $OUT/cov-ocov-oc1-usc-$pb.out | tail -1
  fgrep CPU $OUT/cov-ocov-oc1-usc-$pb.out
done

for b in `seq 1 15`
do
  echo "=== $b (bb, oc=1) ==="
  pb=`printf "%02i" $b`

  $BIN/gringo -cb=$b -coc=1 $ENC/service-cov-ocov.lp \
  | /usr/bin/time -f "$b: %U" -a -o $DIR/times-cov-ocov-oc1-bb.txt \
    clasp --opt-strat=bb > $OUT/cov-ocov-oc1-bb-$pb.out

  egrep Optimization $OUT/cov-ocov-oc1-bb-$pb.out | tail -1
  fgrep CPU $OUT/cov-ocov-oc1-bb-$pb.out
done
