% Assumes s/2, op/3, i/1, uc/2, oc/2, cost/2, o/3, e/3.
maxb(M) :- M = #count{ I: s(I,C)    }.                    % used breaks
t(T)    :- T = #count{ C: op(I,C,Q) }, i(I), slice(Q).    % implicit tracks
maxt(M) :- M =   #max{ T: t(T); 0 }.                      % used tracks
maxq(M) :- M = #count{ Q: op(I,C,Q) }.                    % used slices
maxp(N) :- N =   #max{ P: p(I,Q,P); 0 }.                  % used pros
__usage(B,T,Q,P) :- maxb(B), maxt(T), maxq(Q), maxp(P). #show __usage/4.

% Minimize MC and resources at @2 (primary key) and MC at @1 (secondary key)
#minimize{ 20@2,C,T,mc  : uc(C,T)                 ;  % uc
           20@2,C,T,mc  : oc(C,T)                 ;  % oc
           50@2,I,breaks: I=1..M, maxb(M)         ;  % breaks
           50@2,Q,slices: Q=1..M, maxq(M)         ;  % slices
           50@2,T,tracks: T=1..M, maxt(M)         ;  % tracks
           50@2,P,pros  : P=1..M, maxp(M)         ;  % pros
            K@2,I,C,P   : o(I,(C,Q),P), cost(P,K) ;  % non-experts
            K@2,I,C,P   : e(I,(C,Q),P), cost(P,K) }. % experts
