% heur.lp

info_b_h_l_seed(B,H,H,S) :- max_breaks(B), horizon(H), S=0.

&diff{ b(I) } <= T+1 :- dl(b(I),T).
&diff{ b(I) } >= T-1 :- dl(b(I),T).

%hservis(C,N) :- N = #count{ I : hservi(C,I) }, comp(C).
%:- hservis(C,N), M = #count{ I : servi(C,I) }, M != N.


