% Caso 3 -> Modificação de Z barra
% Adiciona Zb de uma barra existente ao nó de referência
% Z_novo -> Impedancia do novo elo a ser conectado
% barra -> vertice k onde Z_novo sera conectado

function Z_barra_novo = caso3(Z_barra, Z_novo, barra)
a = length(Z_barra);
for n = 1:a+1;
    Z_barra (n,a+1) = Z_barra(n,barra);
    Z_barra (a+1,n) = Z_barra(barra,n);
    Z_barra (a+1, a+1) = Z_barra(barra,barra) + Z_novo;
    Z_barra_novo = Z_barra;
end
Z_barra_novo = Reducao_kron (Z_barra_novo, a+1);
end


