% 2023/2024 © Anssi Yli-Jyrä

% Define expertise as a function of time, progressively:
expert(P,C,1)   :- p(P), expert(P,C),     i(1).
expert(P,C,I+1) :- p(P), expert(P,C,I),   i(I+1). 
expert(P,C,I+1) :- p(P), practice(P,C,I), i(I+1).

% For each operation op(I,C,Q), with expreq(C,EN), assign EN dynamic experts
resource_model3.  % Turn off the earlier rule implementation
{ e(I,(C,Q),P) : p(P), expert(P,C,I) } = EN :- op(I,C,Q), expreq(C,EN).

% Record apprenticeship as practice.
practice(P,C,I) :- o(I,(C,Q),P), expreq(C,EN), EN > 0.
