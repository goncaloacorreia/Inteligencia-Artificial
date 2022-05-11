%estado 0
estado_inicial([
            val(a, va),
            val(b, vb),
            val(c, vc),
            val(d, vd),
            val(e, ve)
        ]).

%alterar consoante o estado final pretendido
estado_final(F):- estado1(F).

estado1([
            val(a, vb),
            val(b, va),
            val(c, vb)
        ]).

estado2_1([ 
            val(a, vb),
            val(c, mais(va, vb))
        ]).

estado2_2([ 
            val(b, va),
            val(d, vc),
            val(e, va)
        ]).

accao(afetar_r(R1, R2), [val(R1, X), val(R2, Y)], [val(R1, Y)], [val(R1, X)] ) :- member(R1, [a, b, c, d, e]),
                                                                            member(R2, [a, b, c, d, e]),
                                                                            member(X, [va, vb, vc, vd, ve]),
                                                                            member(Y, [va, vb, vc, vd, ve]).
                                                                            

accao(somar_r(R1, R2, R3), [val(R1, X1), val(R2, Y), val(R3, Z)], [val(R1, X)], [val(R1, X1)]) :- member(R1, [a, b, c, d, e]),
                                                                                                    member(R2, [a, b, c, d, e]),
                                                                                                    member(R3, [a, b, c, d, e]),
                                                                                                    member(Y, [va, vb, vc, vd, ve]),
                                                                                                    member(Z, [va, vb, vc, vd, ve]),
                                                                                                    X = mais(Y,Z).
