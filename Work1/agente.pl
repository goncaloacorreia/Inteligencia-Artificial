%Tabuleiro 7x7

%estado_inicial(Estado)
%representa a posição inicial do agente A
estado_inicial(e(2,7)).
%visitadas((2,7)).

%estado_final(Estado)
%representa a saída S
estado_final(e(5,1)).

%casas bloqueadas com um X
%bloqueada(Estado)
bloqueada(e(1,2)).
bloqueada(e(3,1)).
bloqueada(e(3,2)).

bloqueada(e(4,4)).
bloqueada(e(4,5)).
bloqueada(e(4,6)).

bloqueada(e(7,2)).


%representação dos operadores de estados
%op(Estado_atual,Operador,Estado_seguinte,Custo)

op(e(X,Y),cima,e(X,Y1),1) :-
    Y > 1,
    Y1 is Y-1,
    \+ bloqueada(e(X,Y1)).

op(e(X,Y),direita,e(X1,Y), 1) :-
   X < 7,
   X1 is X+1,
   \+ bloqueada(e(X1,Y)).

op(e(X,Y),baixo,e(X,Y1),1) :-
    Y < 7,
    Y1 is Y+1,
    \+ bloqueada(e(X,Y1)).

op(e(X,Y),esquerda,e(X1,Y),1) :-
    X > 1,
    X1 is X-1,
    \+ bloqueada(e(X1,Y)).

%Heuristica 1 - Distancia de manhattan
/*h(e(Ix,Iy),SOMA):-
	estado_final(e(Fx,Fy)),
	Dx is abs(Ix - Fx), 
 	Dy is abs(Iy - Fy),
	SOMA is Dx + Dy.*/

%Heuristica 2 - Distancia euclidiana
h(e(Ix,Iy),SOMA):-
	estado_final(e(Fx,Fy)),
	Dx is abs(Ix - Fx), 
 	Dy is abs(Iy - Fy),
	SOMA is round(sqrt(Dy ** 2 + Dx ** 2)).