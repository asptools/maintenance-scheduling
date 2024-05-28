% Optimal allocation of service times for multi-component systems
%   (for clingo-dl v. 1.4.0)
%
% (c) 2023 Tomi Janhunen and Anssi Yli-Jyrä
%
% USAGE:
%   clingo-dl [ -cs=0 ] [ -cm=1 ] [ -ca=<number> ] \
%      [ -cb=<number> ] [ -ch=<number> ] \
%      service-dl.lp [ machine.lp ] -t 8 
%

%#const h=256. #include "sample-machine.octo.lp".
% Models       : 13
% Optimization : 208
% Time         : 10.102s (Solving: 9.91s 1st Model: 2.78s Unsat: 2.85s)
% CPU Time     : 76.519s
%#const h=128. #include "sample-machine.quad.lp".
% Models       : 12
% Optimization : 104
% Time         : 4.382s (Solving: 4.30s 1st Model: 0.79s Unsat: 1.93s)
% CPU Time     : 33.445s
%#const h=64. #include "sample-machine.double.lp".
% Models       : 13
% Optimization : 52
% Time         : 3.454s (Solving: 3.41s 1st Model: 0.22s Unsat: 0.78s)
% CPU Time     : 26.492s
%horizon(32). max_breaks(7). #include "../ASP-service/sample-machine.lp".
% Models       : 6
% Optimization : 26
% Time         : 0.542s (Solving: 0.51s 1st Model: 0.08s Unsat: 0.22s)
% CPU Time     : 3.963s
% 
% Example of a machine that breaks support condition
% horizon(52).max_breaks(8).comp(1,10,9).comp(2,11,0).comp(3,12,0).comp(4,12,1).comp(5,13,0).comp(6,13,1).comp(7,19,2).comp(8,20,0).
% breakat(1,1).breakat(2,2).breakat(3,11).breakat(4,15).breakat(5,21).breakat(6,28).breakat(7,31).breakat(8,41).&diff{ b(I) } = T :- breakat(I,T).

% b : max_breaks(b).
% h : horizon(h).
% l : limit(l).

#show max_breaks/1. 
#show horizon/1. 
#show limit/1.

max_breaks(B) :- info_b_h_l_seed(B,H,L,S).
horizon(H)    :- info_b_h_l_seed(B,H,L,S).
limit(L)      :- info_b_h_l_seed(B,H,L,S).

limit(T)      :- horizon(T).

comp(X,Y)  :- comp(X,Y,Z).
comp(X)    :- comp(X,Y,Z).
comps(N)   :- N = #count{ C : comp(C) }.

i(N)   :- breaks(N), N>0.
i(I-1) :- i(I), I>1.

{ breaks(0..B) } = 1 :- max_breaks(B). #show breaks/1.
j(N+1) :- breaks(N), N<=B, max_breaks(B).
j(I+1) :- j(I), I<=B, max_breaks(B).
&diff{ b(I) } = H+1 :- j(I), horizon(H).
#show j/1.
&diff{ x(C,I+1) - x(C,I) }=0 :- comp(C), 1 < I, j(I), j(I+1).

%% An increasing sequence of i points: 0 < b(1) < b(2) < ... <= h

&diff{ b(I)          } >= 1   :- i(I).         
&diff{ b(I)          } <= L   :- i(I), limit(L).
&diff{ b(I+1) - b(I) }  > 0   :- i(I), i(I+1).

% Expiration

&diff{ x(C,1)   - 1        }=A :- comp(C,_,A).
&diff{ x(C,I+1) - x(C,I)   }=0 :- comp(C), i(I), not servi(C,I).
&diff{ b(I) + R - x(C,I+1) }=0 :- comp(C,R), servi(C,I).

% Break is an emi

b_is_x(I) :- i(I), &diff{ b(I) - x(C,I) } = 0, comp(C).
______b_is_not_x(I) :- not b_is_x(I), i(I). 
#show ______b_is_not_x/1.
%:- not b_is_x(I), i(I).

% Auxiliary f tells the next time step where a serve happens, 416 rules

&diff{ f(C,I)   - H - 1  } = 0   :- comp(C), I=N+1..B+1, breaks(N), max_breaks(B), horizon(H).
&diff{ f(C,I+1) - f(C,I) } = 0   :- comp(C), not servi(C,I), i(I).
&diff{ f(C,I)   - b(I)   } = 0   :- comp(C), servi(C,I).

% Servs 1416 rules @ b=7, h=256

:- not b_is_s(I), i(I).  b_is_s(I) :- servi(C,I).

%servi(C,I) :- qservi(C,I).
%{ servi(C,I) } :- pservi(C,I).
%__surprise(C,I) :- servi(C,I), not qservi(C,I), not pservi(C,I).
%__halfr_k_xminusb(C,I,R/2,K,S) :- __surprise(C,I), comp(C,R), halfskip(I,K), &diff{ x(C,I) - b(I)   } = S, S=1..R.
%#show __halfr_k_xminusb/5. 
%__halfr_bjminusx(C,I,R/2,S) :- __surprise(C,I), comp(C,R), &diff{ b(I+1) - x(C,I)   } = S, S=1..R.
%#show __halfr_bjminusx/4. 
%__halfr_xminusb(C,I,R/2,S) :- __surprise(C,I), comp(C,R), &diff{ x(C,I) - b(I)   } = S, S=1..R.
%#show __halfr_xminusb/4. 
%#show __surprise/2.

{ servi(C,I) } :- comp(C,R), &diff{ x(C,I) - b(I)   } <= K, K< R/2,        halfskip(I,K). % jos emi on max puolet skipistä, joka lt R => ?huolto
servi(C,I)     :- comp(C,R), &diff{ x(C,I) - b(I)   } <  B, B=R/2, K>=R/2, halfskip(I,K). % jos emi on max puolet R:stä, joka lt skippi => huolla
{ servi(C,I) } :- comp(C,R), &diff{ x(C,I) - b(I)   } <  K, K=R-R/2, i(I), moreskip(I).   % jos vähemmän kuin R/2 on vanhaa => ?huolto 
servi(C,I)     :- comp(C,R), &diff{ x(C,I) - b(I)   } <= 0,                i(I).          % jos emi jo vanha niin huolla
servi(C,I)     :- comp(C,R), &diff{ b(I+1) - x(C,I) } >= K, K=R-R/2,       i(I).          % jos emin jälkeen ainakin puolet R:stä => huolla

#show servi/2.

% Aux 320 rules

#show halfskip/2.
halfskip(I,S) :- &diff{ b(I+1) - b(I) } >= S+S-1,
                 &diff{ b(I+1) - b(I) } <= S+S, S=1..M/2, maxskip(M), i(I).
moreskip(I)   :- &diff{ b(I+1) - b(I) } >  S+S, S=M/2,    maxskip(M), i(I).
halfrest(I,S) :- &diff{ H + 1  - b(I) } >= S+S,
                 &diff{ H + 1  - b(I) } <= S+S+1, S=1..M/2, maxskip(M), i(I), horizon(H).
notcut(I)     :- &diff{ b(I+1) - b(I) } >  M,               maxskip(M), i(I).


% Cost function, 8282 rules

step(1..H):- horizon(H).
oc(C,I,K) :- &diff{ x(C,I)   - b(I)  } >= K, K=1..R-1, comp(C,R), servi(C,I).              %#show oc/3.
hc(C,K)   :- &diff{ x(C,N+1) - H - 1 } >= K, K=1..R-1, comp(C,R), breaks(N), horizon(H).   %#show hc/2.
#minimize {  H-A,C   : comp(C,R,A), horizon(H) % 245
  	    ;-R,C,I  : servi(C,I), comp(C,R)   % -243
    	    ;2,C,I,K : oc(C,I,K)               % 14
   	    ;1,C,K   : hc(C,K)                 % 10
           }.  % gold: 256 + 14 + 10 - 11 - 243 = 26

% Constraints, 272 rules

:- i(I), not nonlagging(I).
nonlagging(I) :- servi(C,I), &diff{ x(C,I) - b(I) } >= 0.           % lagging

:- i(I), not notcongested(I).
notcongested(I) :- servi(C,I), &diff{ b(I) - x(C,I) } >= 0.         % congested

:- comp(C), i(I), not servi(C,I), &diff{ x(C,I) - b(I) } <= 0.      % under-tight
:- servi(C,I), &diff{ b(I+1) - x(C,I) } <= 0.                       % overtight

#show servi/2.

% over-servising 2576 rules
% triple overlap => ei tarvitse overlap-tapausten huomioon ottamista

:- &diff{ x(C,I+1) - x(C,I) } <= B, B =R/2, servi(C,I), comp(C,R), notcut(I).     % bg
:- &diff{ x(C,I+1) - x(C,I) } <= K, K< R/2, servi(C,I), comp(C,R), halfrest(I,K). % bgh

:- &diff{ f(C,I+1) - x(C,I) } <= B, B =R/2, servi(C,I), comp(C,R), notcut(I).     % bgb
:- &diff{ f(C,I+1) - x(C,I) } <= K, K< R/2, servi(C,I), comp(C,R), halfrest(I,K). % bgbh

% under-servicing, 1288 rules

lo(C,I) :- &diff{ x(C,I)   - b(I)     } >= 0, comp(C),   i(I).           % left overlap (lo)
nr(C,I) :- &diff{ f(C,I+1) - b(I) - R } >= 0, comp(C,R), i(I), lo(C,I).  % lo but no right overlap

:- &diff{ x(C,I)   - b(I)   } <  B, B=R/2, comp(C,R), not servi(C,I), i(I),          nr(C,I).     % grr
:- &diff{ x(C,I)   - b(I)   } <  K, K<R/2, comp(C,R), not servi(C,I), halfrest(I,K), nr(C,I).     % grh

:- &diff{ f(C,I+1) - b(i)   } >= B, B=R/2, comp(C,R), not servi(C,I), i(I),          not lo(C,I). % rrg (rrgh)
:- &diff{ f(C,I+1) - b(i)   } >= K, K<R/2, comp(C,R), not servi(C,I), halfrest(I,K), not lo(C,I). % rgh

:- &diff{ f(C,I+1) - x(C,i) } >  B, B=R/2, comp(C,R), not servi(C,I), i(I),          lo(C,I).     % grg (grgh)
:- &diff{ f(C,I+1) - x(C,i) } >  K, K<R/2, comp(C,R), not servi(C,I), halfrest(I,K), lo(C,I).     % grgh

% Bounds 238 rules

maxskip(M) :- M = #max{ R1 : comp(C,R1) }.
#show maxskip/1.
&diff{ b(I+1) - b(I) } <= M   :- maxskip(M), i(I), i(I+1).

rbound(I,M*I)   :- i(I), maxskip(M), M*I <  H, horizon(H).
rbound(I,H-N+I) :- i(I), maxskip(M), M*I >= H, breaks(N), horizon(H).
rbound(M)       :- rbound(N,M), breaks(N).
lbound(I,RM-M*(B+1-I)) :- rbound(RM), i(I), maxskip(M), RM-M*(B+1-I) >= 1, max_breaks(B).
lbound(I,I)            :- rbound(RM), i(I), maxskip(M), RM-M*(B+1-I) <  1, max_breaks(B).
&diff{ b(I) } >= L :- lbound(I,L).
&diff{ b(I) } <= R :- rbound(I,R).
#show rbound/2.
#show lbound/2.

