
egrep '==|CPU' runs-scaling-cov-ocov-oc0-usc.txt |
perl -ne '($sum,$comps)=(0,$1) if (/=== ([0-9]+) 1 /); $last = !/===/*$last + /=== [0-9]+ 10 /;  $CPU=s/CPU.*: ([0-9.]*)s/\1/go; $sum+=$1/10; print "$comps: $sum\n" if ($last && $CPU);' >runs-scaling-cov-ocov-oc0-usc.sums.txt

egrep '==|CPU' runs-scaling-cov-ocov-oc1-usc.txt |
perl -ne '($sum,$comps)=(0,$1) if (/=== ([0-9]+) 1 /); $last = !/===/*$last + /=== [0-9]+ 10 /;  $CPU=s/CPU.*: ([0-9.]*)s/\1/go; $sum+=$1/10; print "$comps: $sum\n" if ($last && $CPU);' >runs-scaling-cov-ocov-oc1-usc.sums.txt
