:- dynamic(fechado/1).
:- dynamic(maxNL/1).
:- dynamic(nos/1).

maxNL(0).
nos(0).

inc:- retract(nos(N)), N1 is N+1, asserta(nos(N1)).

actmax(N):- maxNL(N1), N1 >= N,!.
actmax(N):- retract(maxNL(_N1)), asserta(maxNL(N)).
 
pesquisa(Problema,Alg):-
    consult(Problema),
    estado_inicial(S0),
    pesquisa(Alg,[no(S0,[],[],0,0)],Solucao),
    escreve_seq_solucao(Solucao),
    retract(nos(Ns)),retract(maxNL(NL)),
    asserta(nos(0)),asserta(maxNL(0)),
    write(nos(visitados(Ns),lista(NL))),
    retractall(fechado(_)).

pesquisa(profundidade,E,S):- pesquisa_profundidade(E,S).

pesquisa(largura,Ln,Sol):- pesquisa_largura(Ln,Sol).

pesquisa(it,Ln,Sol):- pesquisa_it(Ln,Sol,1).

%Pesquisa em profundidade
pesquisa_profundidade([no(E, Pai, Op, C, P)|_], no(E, Pai, Op, C, P)):-
  estado_final(E), inc.

pesquisa_profundidade([E|R], Sol):- inc ,asserta(fechado(E)),
  expandep(E, Lseg), 
  esc(E),
  insere_inicio(Lseg, R, Resto),
  length(Resto,N),actmax(N),
  pesquisa_profundidade(Resto, Sol).

%Pesquisa em largura
pesquisa_largura([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P)):- 
  estado_final(E), inc.

pesquisa_largura([E|R],Sol):- inc ,asserta(fechado(E)),expandep(E,Lseg),
  esc(E),
  insere_fim(Lseg,R,Resto),
  length(Resto,N),actmax(N),
  pesquisa_largura(Resto,Sol).

expandep(no(E,Pai,Op,C,P),L):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                      (op(E,Opn,En,Cn),
                                      \+ fechado(no(En,_,_,_,_)),
                                      P1 is P+1, Cnn is Cn+C),
                                      L).

%Pesquisa iterativa
pesquisa_it(Ln,Sol,P):- retractall(fechado(E)), pesquisa_pLim(Ln,Sol,P).
pesquisa_it(Ln,Sol,P):- P1 is P+1, pesquisa_it(Ln,Sol,P1).

pesquisa_pLim([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P),_):- 
  estado_final(E), inc.

pesquisa_pLim([E|R],Sol,Pl):- inc ,asserta(fechado(E)),
    expandePl(E, Lseg,Pl), 
    esc(E),
    insere_inicio(Lseg, R, Resto),
    length(Resto,N),actmax(N),
    pesquisa_pLim(Resto, Sol,Pl).

expandePl(no(E,Pai,Op,C,P),[],Pl):- Pl =< P, ! .
expandePl(no(E,Pai,Op,C,P),L,_):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                      (op(E,Opn,En,Cn),
                                      \+ fechado(no(En,_,_,_,_)),
                                      P1 is P+1, Cnn is Cn+C),
                                      L).

insere_inicio([], L, L).
insere_inicio(L, [], L).
insere_inicio(R, T, L):-append(R,T,L).



insere_ord([],L,L).
insere_ord([A|L],L1,L2):- insereE_ord(A,L1,L3), insere_ord(L,L3,L2).

insereE_ord(A,[],[A]).
insereE_ord(A,[A1|L],[A,A1|L]):- menor_no(A,A1),!.
insereE_ord(A,[A1|L], [A1|R]):- insereE_ord(A,L,R).

menor_no(no(_,_,_,_,N,_), no(_,_,_,_,N1,_)):- N < N1.

insere_fim([],L,L).
insere_fim(L,[],L).
insere_fim(R,[A|S],[A|L]):- insere_fim(R,S,L).

%Funções para escrever
escreve_seq_solucao(no(E,Pai,Op,Custo,Prof)):- 
  write(custo(Custo)),nl,
  write(profundidade(Prof)),nl,
  escreve_seq_accoes(no(E,Pai,Op,_,_)).

escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_)):- 
  escreve_seq_accoes(Pai),
  write(e(Op,E)),nl.

esc(A):- write(A), nl.