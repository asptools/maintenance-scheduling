
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp cov-ocov-oc0: ([0-9.]+) /;' out-summary2.txt > times-cov-ocov-oc0-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp cov-ocov-oc1: ([0-9.]+) /;' out-summary2.txt > times-cov-ocov-oc1-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc cov-ocov-oc0: ([0-9.]+) /;' out-summary2.txt > times-cov-ocov-oc0-usc.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc cov-ocov-oc1: ([0-9.]+) /;' out-summary2.txt > times-cov-ocov-oc1-usc.txt

perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp cov-oc0: ([0-9.]+) /;' out-summary2.txt > times-cov-oc0-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp cov-oc1: ([0-9.]+) /;' out-summary2.txt > times-cov-oc1-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc cov-oc0: ([0-9.]+) /;' out-summary2.txt > times-cov-oc0-usc.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc cov-oc1: ([0-9.]+) /;' out-summary2.txt > times-cov-oc1-usc.txt

perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp direct-cov-oc0: ([0-9.]+) /;' out-summary2.txt > times-direct-cov-oc0-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp direct-cov-oc1: ([0-9.]+) /;' out-summary2.txt > times-direct-cov-oc1-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc direct-cov-oc0: ([0-9.]+) /;' out-summary2.txt > times-direct-cov-oc0-usc.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc direct-cov-oc1: ([0-9.]+) /;' out-summary2.txt > times-direct-cov-oc1-usc.txt

perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp scnt-oc0: ([0-9.]+) /;' out-summary2.txt > times-scnt-oc0-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp scnt-oc1: ([0-9.]+) /;' out-summary2.txt > times-scnt-oc1-bb.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc scnt-oc0: ([0-9.]+) /;' out-summary2.txt > times-scnt-oc0-usc.txt
perl -ne 'print "$1: $2\n" if /^b0?([1-9]?[0-9])\.sm clasp-opt-usc scnt-oc1: ([0-9.]+) /;' out-summary2.txt > times-scnt-oc1-usc.txt

perl -ne 'next if (!/^n0?([1-9]?[0-9])-i0?([1-9]?[0-9])\.sm clasp-opt-usc scaling-cov-ocov-oc1: ([^ ]+) /); ($n,$i,$t) = ($1,$2,$3); $t="32800.00" if ($t =~ /NOSTATUS/); $sum=0 if ($i==1); $sum += $t; print "$n: ", ($sum/10), "\n" if $i==10; ' out-summary2.txt  >runs-scaling-cov-ocov-oc1-usc.sums.txt

perl -ne 'next if (!/^n0?([1-9]?[0-9])-i0?([1-9]?[0-9])\.sm clasp-opt-usc scaling-cov-ocov-oc0: ([^ ]+) /); ($n,$i,$t) = ($1,$2,$3); $t="32800.00" if ($t =~ /NOSTATUS/); $sum=0 if ($i==1); $sum += $t; print "$n: ", ($sum/10), "\n" if $i==10; ' out-summary2.txt  >runs-scaling-cov-ocov-oc0-usc.sums.txt

perl -ne 'next if (!/^n0?([1-9]?[0-9])-i0?([1-9]?[0-9])\.sm clasp scaling-cov-ocov-oc1: ([^ ]+) /); ($n,$i,$t) = ($1,$2,$3); $t="32800.00" if ($t =~ /NOSTATUS/); $sum=0 if ($i==1); $sum += $t; print "$n: ", ($sum/10), "\n" if $i==10; ' out-summary2.txt  >runs-scaling-cov-ocov-oc1-bb.sums.txt

perl -ne 'next if (!/^n0?([1-9]?[0-9])-i0?([1-9]?[0-9])\.sm clasp scaling-cov-ocov-oc0: ([^ ]+) /); ($n,$i,$t) = ($1,$2,$3); $t="32800.00" if ($t =~ /NOSTATUS/); $sum=0 if ($i==1); $sum += $t; print "$n: ", ($sum/10), "\n" if $i==10; ' out-summary2.txt  >runs-scaling-cov-ocov-oc0-bb.sums.txt

