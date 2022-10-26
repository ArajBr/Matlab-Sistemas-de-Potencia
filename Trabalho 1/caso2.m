% Caso 2 -> Modificação de Z barra
% Adicionando Zb de uma nova barra a uma barra existente 
% Z_novo -> Impedancia do elo a ser conectado
% barra -> vertice k onde Z_novo sera conectado

function Z_barra_novo = caso2 (Z_barra, Z_novo, barra)
a = length(Z_barra);
%barra=barra-1;
for n = 1:a;
    Z_barra (a+1, a+1) = Z_barra(a,a) + Z_novo;
    Z_barra (n,a+1) = Z_barra(n,a);
    Z_barra (a+1,n) = Z_barra(a,n);
    Z_barra_novo = Z_barra;
    barra=barra+1;
end
end