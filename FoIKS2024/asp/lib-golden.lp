% 2023/2024 © Anssi Yli-Jyrä

% Enforce Fig. 2a breaks

gbreak(1). gbreak(4). gbreak(9). gbreak(14). gbreak(19). gbreak(24). gbreak(29).
:- gbreak(T), not break(T).
