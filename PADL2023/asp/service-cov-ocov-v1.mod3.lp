% Optimal allocation of service times for multi-component systems
%
% 2022/2023/2024 © Tomi Janhunen, Anssi Yli-Jyrä, Masood Feyzbakhsh Rankooh

% Parameters

#const b=10.
#const c=1.
#const h=32.
#const l=32.

time(0..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service

{ break(T): time(T), T>0, T<=l } <= b.
c <= { serv(C,T): comp(C) } :- break(T).

% End of maintenance interval

emi(C,T+R) :- serv(C,T), time(T+R), comp(C,R,_).
emi(C,L+1) :- comp(C,R,L), L>0, time(L+1).

% Coverage reformulated (assuming R>0 and 0<=L<R for all components)


%cov(C,0) :- comp(C,R,L), L>0.
%cov(C,T+1) :- not cov(C,T), not ocov(C,T),
%	      serv(C,T+1), not emi(C,T+1), time(T+1).
%cov(C,T+1) :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
%cov(C,T+1) :- cov(C,T), serv(C,T+1), emi(C,T+1), time(T+1).
%ocov(C,T+1) :- cov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).
%ocov(C,T+1) :- ocov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
%ocov(C,T+1) :- ocov(C,T), serv(C,T+1), emi(C,T+1), time(T+1).
%cov(C,T+1) :- ocov(C,T), not serv(C,T+1), emi(C,T+1), time(T+1).

cov(C,0) :- comp(C,R,L), L>0.
cov(C,T+1) :- not cov(C,T),
	      serv(C,T+1), time(T+1).
cov(C,T+1) :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
cov(C,T+1) :- serv(C,T+1), emi(C,T+1), time(T+1).
ocov(C,T+1) :- cov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).
ocov(C,T+1) :- ocov(C,T), not emi(C,T+1), time(T+1).
cov(C,T+1) :- ocov(C,T), emi(C,T+1), time(T+1).





% Constraints


:- comp(C,R,L), break(T1), not cov(C,T1), not ocov(C,T1).
:- comp(C,R,L), break(T1), ocov(C,T1-1).
:- comp(C,R,L), serv(C,T1), 0 >= #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.
:- comp(C,R,L), not serv(C,T1), break(T1), 0 > #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.
:- not cov(C,T2),  T2>0, time(T2), comp(C), #count { T: break(T), T>0, T<=l } < b.
:- T1>1, break(T1),  not cov(C,T1-1): comp(C), serv(C,T1).
:- break(T1),  ocov(C,T1): comp(C), serv(C,T1).




%valid(1) :- comp(C,_,0).
%valid(T) :- serv(C,T), emi(C,T).
%valid(T-R) :- serv(C,T), emi(C,T), comp(C,R,L), time(T-R), T>R.
%:- break(T), not valid(T).



% Optimization

#const oc=1.
#const se=0.

#minimize {
            1@1,C,T: not cov(C,T), not ocov(C,T),
	             comp(C), time(T), T>0; % Under coverage
            1@1,C,T: ocov(C,T), comp(C), time(T), oc=1; % Over coverage
            1@0,C,T: serv(C,T), se=1                    % Service events
          }.

%cnum(N) :- #count{1,C:comp(C)}==N.
%:- ocov(c,T), cov(c,T).
%#minimize {
%            N@1,T: time(T), cnum(N), T>0;
%            -1@1,C,T: cov(C,T),
%	             comp(C), time(T), T>0 % coverage
%          }.


#show break/1.
#show serv/2.
#show cov/2.
#show ocov/2.

% Check components

error(C) :- comp(C,R,L), R<=0.
error(C) :- comp(C,R,L), L>=R.

#show error/1.

% Sample data

%comp(1,5,2).
%comp(2,10,0).
%comp(3,7,0).
%comp(4,4,3).
%comp(5,9,0).
%comp(6,11,2).
%comp(7,5,4).
%comp(8,8,0).
