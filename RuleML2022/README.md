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
    <td></td>
  </tr>
    <tr>
    <th>over-coverage</th>
    <td>ocov(C,T)</td>
    <td>cov(C,T,2)</td>
    <td>scnt(C,T,2)</td>
    <td>ocov(C,T)</td>
    <td>ocov(C,T)</td>
    <td></td>
  </tr>
</table>
