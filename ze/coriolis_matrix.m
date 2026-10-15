%% Matriz de Coriolis e termos centrípetos C(q,qdot), ex 1.3
%
% Pergunta a que responde: "que forças extra aparecem nas juntas só
% por causa de a inércia M(q) estar a mudar enquanto o braço se mexe?"
% (o mesmo efeito de quando encolhes os braços numa cadeira giratória
% e aceleras sozinho, sem ninguém te empurrar)
%
% Fórmula (símbolos de Christoffel):
%   C_kj = soma_i [ 1/2*(dM_kj/dqi + dM_ki/dqj - dM_ij/dqk) * qidot ]
%
% Esta fórmula só precisa de M(q) -> não há física nova aqui, é só
% derivar M em ordem a q1 e a q2 de forma sistemática.
%
% IMPORTANTE: esta função reaproveita o massmatrix.m já feito e
% validado (ex 1.3) -> não se reescreve a fórmula de M aqui, só se
% chama a função que já existe (projeto iterativo, como combinámos).
%
% NOTA: ao contrário do massmatrix.m (que também podes chamar com
% números), esta função PRECISA de q1 e q2 simbólicos (syms), porque
% usa diff() para derivar M -> derivar só funciona com símbolos,
% nunca com números.

function C = coriolis_matrix(q1, q2, q1dot, q2dot, m1, m2, l1, lc1, lc2, I1, I2)

    % Vai buscar M(q) à função já feita no ex 1.3 (ainda simbólica em
    % q1 e q2, para se conseguir derivar a seguir)
    M = massmatrix(q1, q2, m1, m2, l1, lc1, lc2, I1, I2);

    % Vetores de posição e velocidade das juntas, para percorrer no
    % ciclo em baixo (q(1)=q1, q(2)=q2, etc.)
    q    = [q1, q2];
    qdot = [q1dot, q2dot];
    n = 2;   % número de juntas (graus de liberdade) do robô

    % Inicializa C como matriz 2x2 de zeros simbólicos
    C = sym(zeros(n,n));

    % Percorre todas as combinações k,j,i (cada uma de 1 a 2) e soma
    % a contribuição de cada termo de Christoffel, multiplicada pela
    % velocidade da junta i correspondente (qidot)
    for k = 1:n
        for j = 1:n
            for i = 1:n
                % Termo de Christoffel: mede como a "sensibilidade"
                % entre as juntas k e j muda por causa da junta i
                c_ijk = 0.5*( diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)) );
                C(k,j) = C(k,j) + c_ijk*qdot(i);
            end
        end
    end

    % Simplifica a expressão final (junta termos, cancela o que dá
    % para cancelar) para ficar mais legível
    C = simplify(C);
end