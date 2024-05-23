## The Prior Art Encodings

These baseline encodings were originally published in RuleML2022:

- service-cov-ocov.lp  -  '2-Level Encoding' 
- service-cov.lp  - '2-Level (compact) Encoding' 
- service-direct-cov.lp - '1-Level Encoding' 
- service-scnt.lp - 'Elevator Encoding' 

The following table is the comparison of the PADL2023 encodings.   The 6th column describes the fifth model ('Mixed Encoding') that was published in PADL2023.

<table>
  <tr>
    <th></th>
    <th>2-Level Encoding</th>
    <th>Compact Encoding</th>
    <th>Elevator Encoding</th>
    <th>Mixed Encoding</th>
    <th>1-Level Encoding</th>
  </tr>
  <tr>
    <th>under-coverage</th>
    <td>not cov(C,T), not ocov(C,T)</td>
    <td>not cov(C,T,1), not cov(C,T,2)</td>
    <td>scnt(C,T,0)</td>
    <td>not cov(C,T)</td>
    <td>not cov(C,T)</td>
  </tr>
  <tr>
    <th>coverage</th>
    <td>cov(C,T)</td>
    <td>cov(C,T,1)</td>
    <td>scnt(C,T,1)</td>
    <td>cov(C,T), not ocov(C,T)</td>
    <td>cov(C,T), not ocov(C,T)</td>
  </tr>
    <tr>
    <th>over-coverage</th>
    <td>ocov(C,T)</td>
    <td>cov(C,T,2)</td>
    <td>scnt(C,T,2)</td>
    <td>cov(C,T), ocov(C,T)</td>
    <td>cov(C,T), ocov(C,T)</td>
  </tr>
    <tr>
    <th>steps</th>
    <td>time(0..h)</td>
    <td>time(0..h)</td>
    <td>time(0..h)</td>
    <td>time(1..h)</td>
    <td>time(1..h)</td>
  </tr>
    <tr>
    <th>cov(C,0)</th>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>cov(C,T)</th>
    <td></td>
    <td></td>
    <td></td>
    <td>comp(C,R,L), L>0, T=1..L</td>
    <td>comp(C,R,L), L>0, T=1..L</td>
  </tr>
    <tr>
    <th>0 to 1</th>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T), not ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T,1), not cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,0)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>1 to 2</th>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T), <br>[not ocov(C,T)]</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>1 to 0</th>
    <td>n/a</td>
    <td>n/a</td>
    <td>emi(C,T), scnt(C,T-1,N), not serv(C,T), N=1</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>2 to 1</th>
    <td>emi(C,T+1), not serv(C,T+1), ocov(C,T)</td>
    <td>emi(C,T+1), not serv(C,T+1), cov(C,T,2)</td>
    <td>emi(C,T+1), not serv(C,T+1), scnt(C,T,N), N=2</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>0-0</th>
    <td>n/a</td>
    <td>n/a</td>
    <td>serv(C,T+1), emi(C,T+1), scnt(C,T,V), V=0</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>1-1</th>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T)
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T)</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=1</td>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=1</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>2-2</th>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
    <hr>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=2
    <hr/>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=2
    <hr/>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
    <hr/>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>3</th>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
  </tr>
</table>

* For easier comparison, the following changes has been made.  In Elevator Encoding, the predicate symbols dec/2 and inc/2 have been replaced with predicate symbols emi/2 and serv/2.  Predicat emi has been defined by

  ```
  emi(C,T+R) :- time(T+R), serv(C,T), comp(C,R,L), time(T+R).
  emi(C,L+1) :- time(L+1), comp(C,R,L), L>0. 
  ```

