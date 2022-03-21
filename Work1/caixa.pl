%Tabuleiro 7x7

%estado_inicial(Estado)
%representa a posição inicial do agente A

estado_inicial(p(2,7,2,6)).

%estado_final(Estado)
%representa a saída S
estado_final(p(_,_,5,1)).

%casas bloqueadas com um X
%bloqueada(Estado)
bloqueada(p(1,2)).
bloqueada(p(3,1)).
bloqueada(p(3,2)).

bloqueada(p(4,4)).
bloqueada(p(4,5)).
bloqueada(p(4,6)).

bloqueada(p(7,2)).

%Limites do tabuleiro
lim(X,Y) :- X=<7, X>=1, Y=<7,Y>=1.

%representação dos operadores de estados
%op(Estado_atual,Operador,Estado_seguinte,Custo)

% Operação do agente seguir para cima
op(p(X,Y,P,Q),cima,p(X,Y1,P,Q1),1) :-

    Y1 is Y-1,

    (iguais(p(X,Y1),p(P,Q)) ->
        (
            Q1 is Q-1,
            lim(P,Q1),
            \+ bloqueada(p(P,Q1))
        );
        (
            Q1 is Q,
            lim(X,Y1),
            \+ bloqueada(p(X,Y1))
        )
    ).

% Operação do agente seguir para a direita
op(p(X,Y,P,Q),direita,p(X1,Y,P1,Q),1) :-

    X1 is X+1,

    (iguais(p(X1,Y),p(P,Q)) ->
        (
            P1 is P+1,
            lim(P1,Q),
            lim(X1,Y),
            \+ bloqueada(p(P1,Q))
        );
        (
            P1 is P,
            lim(X1,Y),
            \+ bloqueada(p(X1,Y))
        )
    ).

% Operação do agente seguir para baixo
op(p(X,Y,P,Q),baixo,p(X,Y1,P,Q1),1) :-

    Y1 is Y+1,

    (iguais(p(X,Y1),p(P,Q)) ->
        (
            Q1 is Q+1,
            lim(P,Q1),
            lim(X,Y1),
            \+ bloqueada(p(P,Q1))
        );
        (
            Q1 is Q,
            lim(X,Y1),
            \+ bloqueada(p(X,Y1))
        )
    ).

% Operação do agente seguir para a esquerda
op(p(X,Y,P,Q),esquerda,p(X1,Y,P1,Q),1) :-

    X1 is X-1,

    (iguais(p(X1,Y),p(P,Q)) ->
        (
            P1 is P-1,
            lim(P1,Q),
            lim(X1,Y),
            \+ bloqueada(p(P1,Q))
        );
        (
            P1 is P,
            lim(X1,Y),
            \+ bloqueada(p(X1,Y))
        )
    ).

%Predicado que vai verificar se são iguais as posições do agente e da caixa
iguais(P1,P1).

%Heuristica 1 - Distância de Manhattan
h(p(_,_,Ix,Iy),SOMA):-
	estado_final(p(_,_,Fx,Fy)),
	Dx is abs(Ix - Fx), 
 	Dy is abs(Iy - Fy),
	SOMA is Dx + Dy.

%Heuristica 2 - Distancia euclidiana
/*h(p(_,_,Ix,_),SOMA):-
	estado_final(p(_,_,Fx,_)),
	Dx is abs(Ix - Fx), 
	SOMA is Dx.*/