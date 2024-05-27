#!/bin/bash

BIN=../bin.m1
ENC=..
IN=in
DIR=`pwd`

# Remember to comment the sample machine out from service-cov-ocov.lp

for enc in cov-ocov 
 # cov scnt direct-cov
do
  for n in `seq 1 16`
  do	 
    nb=`printf "%02i" $n`
    for oc in 0 1
    do
	for i in `seq 1 10`
	do
            ib=`printf "%02i" $i`
	    r=$RANDOM
	    echo "=== $n $i ($r) ==="
	    
	    if test ! -d $IN/scaling-$enc-oc$oc
	    then
		mkdir -p $IN/scaling-$enc-oc$oc
	    fi
	    $BIN/gringo -cn=$n ../machgen.lp | $BIN/clasp --seed=$r --rand-freq=0.2 \
		| fgrep comp | perl -ne 's/\) */).\n/go; print; ' \
		| $BIN/gringo -coc=$oc -cb=8 - ../service-$enc-nosample.lp > $IN/scaling-$enc-oc$oc/n$nb-i$ib.sm
	    gzip $IN/scaling-$enc-oc$oc/n$nb-i$ib.sm
            # | $BIN/clasp --time-limit=1200 --opt-strat=usc --quiet=1,0
	done 
    done 
  done 
done



