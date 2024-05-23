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
    <th>1-Level Encoding</th>
    <th>Mixed Encoding</th>
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
    <td>cov(C,T,S), cov(C,T)</td>
    <td>cov(C,T,S), cov(C,T)</td>
  </tr>
    <tr>
    <th>over-coverage</th>
    <td>ocov(C,T)</td>
    <td>cov(C,T,2)</td>
    <td>scnt(C,T,2)</td>
    <td>ocov(C,T)</td>
    <td>ocov(C,T)</td>
  </tr>
    <tr>
    <th>no lifetime</th>
    <td>n/a</td>
    <td>n/a</td>
    <td>comp(C,R,0)</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>reset</th>
    <td>serv(C,T)</td>
    <td>serv(C,T)</td>
    <td>inc(C,T)</td>
    <td>n/a</td>
    <td>serv(C,T)</td>
  </tr>
    <tr>
    <th>comp(C,R,L), L>0, time(L+1)</th>
    <td></td>
    <td>emi(C,T)</td>
    <td>dec(C,T)</td>
    <td>emi(C,T)</td>
    <td></td>
  </tr>
    <tr>
    <th>comp(C,R,_), serv(C,T), time(T+R)</th>
    <td>emi(C,T)</td>
    <td>emi(C,T)</td>
    <td>dec(C,T)</td>
    <td>emi(C,T)</td>
    <td>emi(C,T)</td>
  </tr>
    <tr>
    <th>cov at T=0</th>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
  </tr>
    <tr>
    <th>0 to 1</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,0), inc(C,T), not dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>1 to 2</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,1), inc(C,T), not dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>0-0</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,0), inc(C,T), dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>1-1</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,1), inc(C,T), dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>2-2</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,2), inc(C,T), dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>2 to 1</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,2), not inc(C,T), dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>1 to 0</th>
    <td></td>
    <td></td>
    <td>scnt(C,T-1,2), not inc(C,T), dec(C,T)</td>
    <td></td>
    <td></td>
  </tr>
</table>

inc(C,T) :- serv(C,T).
dec(C,T+R) :- serv(C,T), comp(C,R,_), time(T+R).
dec(C,L+1) :- comp(C,R,L), 0<L, time(L+1).        % For lifetime L

scnt(C,0,0) :- comp(C,R,0).
scnt(C,0,1) :- comp(C,R,L), 0<L.                  % For lifetime L
val(0..2).

scnt(C,T,V+1) :- inc(C,T), not dec(C,T), scnt(C,T-1,V),    % Increase
                 comp(C), time(T), val(V), val(V+1).

scnt(C,T,V-1) :- not inc(C,T), dec(C,T), scnt(C,T-1,V),    % Decrease
                 comp(C), time(T), val(V), val(V-1).

scnt(C,T,V) :- scnt(C,T-1,V), not inc(C,T), not dec(C,T),  % Inertia 1
               comp(C), time(T), val(V), time(T-1).
