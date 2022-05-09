%estado 0
estado_inicial([
            val(a, va),
            val(b, vb),
            val(c, vc),
            val(d, vd),
            val(e, ve)
        ]).

%alterar consoante o estado final pretendido
estado_final(F):- estado_1(F).

estado_1([
            val(a, vb),
            val(b, va),
            val(c, vb),
            val(d, vd),
            val(e, ve)
        ]).

estado_2([
            val(a, vb),
            val(b, va),
            soma(c, va, vb),
            val(d, vc),
            val(e, va)
        ]).

accao(afetar_r(R1, R2), [val(R1, X), val(R2, Y)], [val(R1, Y)], [val(R1, X)] ) :- member(R1, [a, b, c, d, e]),
                                                                            member(R2, [a, b, c, d, e]),
                                                                            member(X, [va, vb, vc, vd, ve]),
                                                                            member(Y, [va, vb, vc, vd, ve]).
                                                                            
%alterar ! ! !
accao(somar_r(R1, R2, R3), [val(R1, X), val(R2, Y), val(R3, Z)], [soma(R1, Y, Z)], [val(R1, X)]) :- member(R1, [a, b, c, d, e]),
                                                                                                    member(R2, [a, b, c, d, e]),
                                                                                                    member(R3, [a, b, c, d, e]),
                                                                                                    member(X, [va, vb, vc, vd, ve]),
                                                                                                    member(Y, [va, vb, vc, vd, ve]),
                                                                                                    member(Z, [va, vb, vc, vd, ve]).