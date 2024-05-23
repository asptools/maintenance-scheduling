## The Prior Art Encodings

These baseline encodings were originally published in RuleML2022:

- service-scnt.lp - 'Elevator Encoding' 
- service-cov-ocov.lp  -  '2-Level Encoding' 
- service-cov.lp  - '2-Level (compact) Encoding' 
- service-direct-cov.lp - '1-Level Encoding' 

The following table is the comparison of the PADL2023 encodings.   The Mixed Encoding was published in PADL2023 but is include (with slight changes) into the table for completeness.

<table>
  <tr>
    <th></th>
    <th>Elevator Encoding</th>
    <th>Compact Encoding</th>
    <th>2-Level Encoding</th>
    <th>Mixed Encoding</th>
    <th>1-Level Encoding</th>
  </tr>
  <tr>
    <th>Under-coverage</th>
    <td>scnt(C,T,0)</td>
    <td>not cov(C,T,1), not cov(C,T,2)</td>
    <td>not cov(C,T), not ocov(C,T)</td>
    <td>not cov(C,T)</td>
    <td>not cov(C,T)</td>
  </tr>
  <tr>
    <th>Coverage</th>
    <td>scnt(C,T,1)</td>
    <td>cov(C,T,1)</td>
    <td>cov(C,T)</td>
    <td>cov(C,T), not ocov(C,T)</td>
    <td>cov(C,T), not ocov(C,T)</td>
  </tr>
    <tr>
    <th>Over-coverage</th>
    <td>scnt(C,T,2)</td>
    <td>cov(C,T,2)</td>
    <td>ocov(C,T)</td>
    <td>cov(C,T), ocov(C,T)</td>
    <td>cov(C,T), ocov(C,T)</td>
  </tr>
    <tr>
    <th>Time steps</th>
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
    <th>Direct cov(C,T)</th>
    <td></td>
    <td></td>
    <td></td>
    <td>comp(C,R,L), T=1..L
      <hr/>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>comp(C,R,L), T=1..L
      <hr/>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>Increment 0 to 1</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,0)</td>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T,1), not cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T), not ocov(C,T)</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Increment 1 to 2</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T), <br>[not ocov(C,T)]</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>Decrement 1 to 0</th>
    <td>emi(C,T), not serv(C,T), scnt(C,T-1,N), N=1</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Decrement 2 to 1</th>
    <td>emi(C,T+1), not serv(C,T+1), scnt(C,T,N), N=2</td>
    <td>emi(C,T+1), not serv(C,T+1), cov(C,T,2)</td>
    <td>emi(C,T+1), not serv(C,T+1), ocov(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>Inertia of under-coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,V), V=0</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Inertia of single coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=1</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=1</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T)
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>Inertia of over-coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=2
      <hr/>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=2
      <hr/>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
      <hr>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
      <hr/>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>Constraint for 3-fold coverage</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
  </tr>
</table>

* For easier comparison, the following changes has been made.  In Elevator Encoding, the predicate symbols dec/2 and inc/2 have been replaced with predicate symbols emi/2 and serv/2.  Predicat emi has been defined by

  ```
  emi(C,T+R) :- time(T+R), serv(C,T), comp(C,R,L), time(T+R).
  emi(C,L+1) :- time(L+1), comp(C,R,L), L>0. 
  ```

In the 1- to 2-fold coverage increments of Mixed encoding, the condition `not ocov(C,T)` has been dropped as redundant.  There is the constraint that blocks increments from 2- to 3-fold coverage. 
  
Furhermore, the new encoding (Mixed Encoding) in this table differs from service-cov-mixed-v1.lp slightly.  The changed new encoding is stored as the file service-cov-mixed-v2.lp.  None of the encodings has been included to the tests of the paper and the changed encoding service-cov-mixed-v2.lp has not been included to the tests of the follow-up paper in PADL2023.   The changed encoding is likely to be an improvement.
 
