member1(X, []) :- fail.
member1(X, [A| L]) :- X \= A, member1(X, L).
member1(X, [X, _]).

juntar([], L, L).
juntar([A| L], L1, [A| L2]) :- juntar(L, L1, L2).