%a)
%estado_inicial(e(0,0,1,2)). %representar as filas que temos
estado_inicial(e(1,3,5,7)). %exemplo da wikipedia

%b)
terminal(e(0,0,0,0)).

%c) Definir a função de utilidade (usando minimax que se chama a função valor)

valor(E,-1,P) :- terminal(E), R is P mod 2, R=1. %se a profundidade for impar, o computadorm perdeu e nós ganhamos

valor(E,1,P) :- terminal(E), R is P mod 2, R=0.  %se a profundidade for par, o computador ganhou e nós perdemos


%op1(E,Jogada,Es)   E- primeiro estado, Jogada, Es- estado seguinte
op1(e(N1,N2,N3,N4),ret(1,N),e(N11,N2,N3,N4)) :- numero(1,N), N11 is N1 - N, N11 >= 0.

op1(e(N1,N2,N3,N4),ret(2,N),e(N1,N22,N3,N4)) :- numero(1,N), N22 is N2 - N, N22 >= 0.

op1(e(N1,N2,N3,N4),ret(3,N),e(N1,N2,N33,N4)) :- numero(1,N), N33 is N3 - N, N13 >= 0.

op1(e(N1,N2,N3,N4),ret(4,N),e(N1,N2,N3,N44)) :- numero(1,N), N14 is N4 - N, N44 >= 0.

maximo(7).


%numero
numero(N,N).
numero(L,N1) :- maximo(M), L<M, L1 is L+1, numero(L1,N1).  %gera todos os numeros em backtracking até um certo numero