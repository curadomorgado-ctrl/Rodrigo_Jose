
function C = Ex3_CoriolisMatrix_Symbolic(q, dq, M)

    C = sym(zeros(2,2));

    for i = 1:2
        for j = 1:2
            for k = 1:2
                C(i,j) = C(i,j) + 0.5 * ( ...
                    diff(M(i,j), q(k)) ...
                  + diff(M(i,k), q(j)) ...
                  - diff(M(j,k), q(i))) * dq(k);
            end
        end
    end

    C = simplify(C);
end
