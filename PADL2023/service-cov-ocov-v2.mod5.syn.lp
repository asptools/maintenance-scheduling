% Optimal allocation of service times for multi-component systems
%
% (c) 2022 Tomi Janhunen, Masood F. Rankooh, Anssi Yli-Jyrä
%
% v2 completed on 12 Sept 2023 by AYJ
% v2 = 'fix'-flag added, defaul fix=0
% v2 = Table-based hand validation of cases indicated that v1 was 'incorrect'
% v2 = restored TRIPLE OVERLAP EXCLUSION constraint of cov-ocov-v1.lp
%      but it turns out that 3-overlap exclusion rule is not necessary because of the costs
% v2 = fixed transition from ocov(C,T),emi(C,T+1),serv(C,T+1) to ocov(C,T+1) (=TRIPLE CONTACT)
%      but it turns out that v1 is better because the contact transition can be excluded by optimization
%   => TRIPLE CONTACT EXCLUSION constraint
% fix=1 seems to be slightly slower than v1
% fix=0 (default) uses cov-ocov-v1 rules, but only adds ocov+serv (= TRIPLE EXCLUSION) constraint

% Parameters

#const b=7.
#const c=1.
#const h=32.
#const l=32.

time(0..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service
% { break(T): time(T), T>0, T<=l }  = b.            % 104.179s
% { break(T): time(T), T>0, T<=l } <= b.            % 122.625s
%   i.e. floating b is 20% slower
breaki(1..N) :- breakn(N).                          %
breakn(b).                                          % 
% { break(T): time(T), T>0, T<=l } = N :- breakn(N).% 101.763s
%   i.e. breakn does not make selecting breaks slower
%   i.e. selecting breaks is not as fast as selecting breakats (see down)
{ breakn(0..b) } = 1.                               % 250.917s
%   i.e. floating b is now 150% slower!
:- breakat(I,T), breakat(I+1,T2), T >= T2.          % validate breakats
:- breakat(I,T), breakat(I,T2), T != T2.            % validate breakats
% { breakat(I,T): breaki(I) } = 1 :- break(T).      % 149.349s
%   i.e. selecting breaks is not as fast as selecting breakats (see down)
%   i.e. interface to numbered breaks makes it reasonably 50% slower at b7h32
%   b x h new atoms and O(b x h) new rules are introduced

% use minmedian to estimate the right bound of each break
rightmostbreak(I,M*I) :- breaki(I), minmedian(M), M*I < h.
rightmostbreak(I,h)   :- breaki(I), minmedian(M), M*I >=h.
rightmostbreak(M) :- rightmostbreak(b,M).
#show rightmostbreak/2.
leftmostbreak(I,RM-M*(b+1-I)) :- rightmostbreak(RM), breaki(I), minmedian(M), RM-M*(b+1-I) >= 1.
leftmostbreak(I,1)            :- rightmostbreak(RM), breaki(I), minmedian(M), RM-M*(b+1-I) <  1.
#show leftmostbreak/2.

%:- breakat(I,T), T < M, leftmostbreak(I,M).               % (1) 
%:- breakat(I,T), T > M, rightmostbreak(I,M).              % (2) (1+2)=185.175s
:- breakat(I,T), breakat(I+1,T2), minmedian(M), T+M < T2.  % (3) (3)=288.513s
%    all (1-3) together 79.203s - 99.389s i.e. bounding breakat ranges helps

{ breakat(I,T) : T=L..R } = 1 :- leftmostbreak(I,L), rightmostbreak(I,R).  % 56.292s
break(T) :- breakat(I,T).
%    i.e. selecting bounded breakats is faster than selecting breaks and then bounding breakats

#show breaki/1.
#show minmedian/1.
#show leftmostbreak/2.

c <= { serv(C,T): comp(C) } :- break(T).


% End of maintenance interval

emi(C,T+R) :- serv(C,T), time(T+R), comp(C,R,_).
emi(C,L+1) :- comp(C,R,L), L>0, time(L+1).

% Coverage reformulated (assuming R>0 and 0<=L<R for all components)

#const lv=1.
#const so=1.

% Auxiliary coverage predicates (assuming R>0 and 0<=L<R for all components)
#const fix=0.  % the fix was shown to be useless
cov(C,0)    :- comp(C,R,L), L>0.                                             % 0 SETUP
cov(C,T+1)  :- fix>0, not cov(C,T), serv(C,T+1), time(T+1), not emi(C,T+1).  % 1 UP added not emi(C,T+1) 
cov(C,T+1)  :- fix=0, not cov(C,T), serv(C,T+1), time(T+1).                  % 1 UP (cov-ocov)
cov(C,T+1)  :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).         % 2 INER
cov(C,T+1)  :- fix>0, serv(C,T+1), emi(C,T+1), time(T+1), not ocov(C,T).     % 6 INERT added not ocov(C,T)
cov(C,T+1)  :- fix=0, serv(C,T+1), emi(C,T+1), time(T+1).                    % 6 INERT (cov-ocov)
ocov(C,T+1) :- cov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).             % 3 UP
ocov(C,T+1) :- ocov(C,T), not emi(C,T+1), time(T+1).                         % 4 INER (ignore not serv(C,T+1))
cov(C,T+1)  :- fix>0, ocov(C,T), emi(C,T+1), time(T+1), not serv(C,T+1).     % 5 DOWN added not serv(C,T+1)
cov(C,T+1)  :- fix=0, ocov(C,T), emi(C,T+1), time(T+1).                      % 5 DOWN (cov-ocov)
ocov(C,T+1) :- fix>0, ocov(C,T), time(T+1), serv(C,T+1).                     % 7 INER rule added (ignore emi)
            :- fix>0, ocov(C,T), not emi(C,T+1), serv(C,T+1).                % 8 TRIPLE OVERLAP EXCLUSION
            :- fix>0, ocov(C,T),     emi(C,T+1), serv(C,T+1).                % 9 TRIPLE CONTACT EXCLUSION
            :- fix=0, ocov(C,T), serv(C,T+1).                                % 10 TRIPLE EXCLUSION

% fix=1: (v2)
%           -serv-emi  -serv+emi  +serv-emi        +serv+emi
% red       (red)      (n/a)      1=cov            6 (n/a)
% cov       2=cov      (red)      3=ocov           6=cov
% ocov      4=ocov     5=cov      1,4,7,8,9 (n/a)  7=ocov,9=>n/a
%
% S---------S---------
%      S---------
% GGGGGBBBBBBBBBBGGGGG => correct mc computation
% S---------
%    S---------
%       S---------
% GGGBBB* => triple overlap exclusion
%
% fix=0: (v1)
%           -serv-emi  -serv+emi  +serv-emi      +serv+emi
% red       (red)      (n/a)      1=cov          1,6 (n/a)
% cov       2=cov      (red)      3=ocov         6=cov
% ocov      4=ocov     5=cov      1,4 (n/a)      1,5,6=cov!!!
%
% S---------S---------
%      S---------
% GGGGGBBBBBGGGGGRRRRR => incorrect miscoverage computed
% but the above can be always replaced with:
% S---------S---------
% GGGGGGGGGGGGGGGGGGGG => much better miscoverage
% So, rule 7 is useless 
%
% S---------
%    S---------
%       S---------
% GGGBBBGGGGRRRRRR => inccorect
% but can always be replaced with
% S---------
%       S---------
% GGGGGGBBBBGGGGGG => much better miscoverage
% So, rule 8 is useless 

% Constraints

:- comp(C,R,L), break(T1), not cov(C,T1), not ocov(C,T1).
:- comp(C,R,L), break(T1), ocov(C,T1-1).
:- comp(C,R,L), serv(C,T1), 0 >= #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.
:- comp(C,R,L), not serv(C,T1), break(T1), 0 > #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.

% :- break(T1), ocov(C,T1): comp(C).           % 620.850s congested
:- break(T1), ocov(C,T1): comp(C), serv(C,T1). % 564.409s congested wrt serv 
% :- T1>1, break(T1), not  cov(C,T1-1): comp(C), serv(C,T1);
%                     not ocov(C,T1-1): comp(C), serv(C,T1). % 194.327s, -t8 703.209s reds & serv
:- T1>1, break(T1), not  cov(C,T1-1): comp(C), serv(C,T1).   % 124.039s, -t8 505.392s non-green & serv
% :- T1>1, break(T1), not  cov(C,T1-1): comp(C).             % 165.619s,168.880s, -t8 471.350s non-green  
% :- T1>1, break(T1), not  cov(C,T1-1): comp(C);
%                     not ocov(C,T1-1): comp(C).             % 184.905s, -t8 430.691s reds

% Optimization

#const oc=1.
#const se=0.

#minimize {
            1@1,C,T: not cov(C,T), not ocov(C,T),
	             comp(C), time(T), T>0; % Under coverage
            1@1,C,T: ocov(C,T), comp(C), time(T), oc=1; % Over coverage
            1@0,C,T: serv(C,T), se=1                    % Service events
          }.

#show break/1.
%#show serv/2.
%#show cov/2.
%#show ocov/2.

% Check components

error(C) :- comp(C,R,L), R<=0.
error(C) :- comp(C,R,L), L>=R.

#show error/1.

% Sample data
%1 = { compi(1..8) } = 1. % it is not a good idea to use compi in dl rules
%comp(1,5,2) :- compi(1).
%comp(1,10,0):- compi(2).
%comp(1,7,0) :- compi(3).
%comp(1,4,3) :- compi(4).
%comp(1,9,0) :- compi(5).
%comp(1,11,2):- compi(6).
%comp(1,5,4) :- compi(7).
%comp(1,8,0) :- compi(8).
comp(1,5,2).
comp(2,10,0).
comp(3,7,0).
comp(4,4,3).
comp(5,9,0).
comp(6,11,2).
comp(7,5,4).
comp(8,8,0).
minmedian(7). % 4,5,5,[7], 10,9,11,8
#show comp/3.

