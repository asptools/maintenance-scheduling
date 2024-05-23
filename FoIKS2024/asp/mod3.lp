% (c) 2022 Tomi Janhunen, Anssi Yli-Jyrä, Masood F. Rankooh
% Constraints

:- comp(C,R,L), break(T1), not cov(C,T1), not ocov(C,T1).
:- comp(C,R,L), break(T1), ocov(C,T1-1).
:- comp(C,R,L), serv(C,T1), 0 >= #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.
:- comp(C,R,L), not serv(C,T1), break(T1), 0 > #sum{ -1,T2: not cov(C,T2), time(T2), T2>=T1, T2<T1+R; 1,T3: cov(C,T3), time(T3), T3>=T1, T3<T1+R }.
:- not cov(C,T2),  T2>0, time(T2), comp(C), #count { T: break(T), T>0, T<=l } < b.
:- T1>1, break(T1),  not cov(C,T1-1): comp(C), serv(C,T1).
:- break(T1),  ocov(C,T1): comp(C), serv(C,T1).


