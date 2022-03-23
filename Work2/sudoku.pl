% Problema do Sudoku

% Cada posição da variável (X,Y) varia entre 1 e 9
% O dominio das variáveis varia também entre 1 e 9, uma vez que temos uma vez que os quadrantes são 3x3

size(9).

dominio([1,2,3,4,5,6,7,8,9]).

estado_inicial(e([v(c(1,1,1),D,_),v(c(1,3,1),D,_),v(c(1,4,2),D,_),v(c(1,5,2),D,_),v(c(1,7,3),D,_),
				  v(c(2,1,1),D,_),v(c(2,2,1),D,_),v(c(2,3,1),D,_),v(c(2,5,2),D,_),v(c(2,7,3),D,_),v(c(2,8,3),D,_),v(c(2,9,3),D,_),
				  v(c(3,2,1),D,_),v(c(3,3,1),D,_),v(c(3,4,2),D,_),v(c(3,5,2),D,_),v(c(3,6,2),D,_),v(c(3,8,3),D,_),
				  v(c(4,1,4),D,_),v(c(4,2,4),D,_),v(c(4,3,4),D,_),v(c(4,4,5),D,_),v(c(4,5,5),D,_),v(c(4,7,6),D,_),v(c(4,8,6),D,_),v(c(4,9,6),D,_),
				  v(c(5,1,4),D,_),v(c(5,2,4),D,_),v(c(5,3,4),D,_),v(c(5,4,5),D,_),v(c(5,7,6),D,_),
				  v(c(6,2,4),D,_),v(c(6,3,4),D,_),v(c(6,5,5),D,_),v(c(6,6,5),D,_),v(c(6,7,6),D,_),v(c(6,8,6),D,_),v(c(6,9,6),D,_),
				  v(c(7,1,7),D,_),v(c(7,2,7),D,_),v(c(7,3,7),D,_),v(c(7,5,8),D,_),v(c(7,6,8),D,_),v(c(7,7,9),D,_),v(c(7,8,9),D,_),v(c(7,9,9),D,_),
				  v(c(8,3,7),D,_),v(c(8,4,8),D,_),v(c(8,6,8),D,_),v(c(8,7,9),D,_), v(c(8,9,9),D,_),
				  v(c(9,1,7),D,_),v(c(9,2,7),D,_),v(c(9,4,8),D,_),v(c(9,5,8),D,_), v(c(9,7,9),D,_), v(c(9,8,9),D,_),v(c(9,9,9),D,_)],
	
				  

% Posições já preenchidas na tabela dada
[v(c(1,2,1),D,1),v(c(1,6,2),D,8), v(c(1,8,3),D,7), v(c(1,9,3),D,3),
v(c(2,4,2),D,6), v(c(2,6,2),D,9),
v(c(3,1,1),D,7), v(c(3,7,3),D,9), v(c(3,9,3),D,4), 
v(c(4,6,5),D,4), 
v(c(5,5,5),D,3), v(c(5,6,5),D,6), v(c(5,8,6),D,1), v(c(5,9,6),D,8), 
v(c(6,1,4),D,8), v(c(6,4,5),D,9),
v(c(7,4,8),D,7), 
v(c(8,1,7),D,2), v(c(8,2,7),D,5), v(c(8,5,8),D,4), v(c(8,8,9),D,3), 
v(c(9,3,7),D,6), v(c(9,6,8),D,3)])):- dominio(D).

ve_restricoes(e(_,[v(c(X,Y,Z), _, V)|Afect])):-
	findall(V1,member(v(c(X,_,_),_,V1),Afect),L), all_diff([V|L]),
	findall(V2,member(v(c(_,Y,_),_,V2),Afect),L2), all_diff([V|L2]),
	findall(V3,member(v(c(_,_,Z),_,V3),Afect),L3), all_diff([V|L3]),
	L \= L2, L3\=L, L3\=L2.

all_diff([]).
all_diff([X|Afect]):-
	\+ member(X,Afect), all_diff(Afect).

% Predicado para escrever o tabuleiro
esc(L):-sort(L, L1), esc_a(L1),nl.

esc_a(L):- size(S), esc_l(L, 1, S).

esc_l([H], S, S):- H = v(_,_,X), write(X),nl.

esc_l([H|T], S, S):- H = v(_,_,X), write(X), nl, esc_l(T, 1, S).

esc_l([H|T], I, S):- I<S, I2 is I+1, H = v(_,_,X), write(X),write(' . '),esc_l(T, I2, S).