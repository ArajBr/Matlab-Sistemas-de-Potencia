% Caso 1 -> Modificação de Z barra
% Adiciona uma barra com inicio na referencia

function Z_barra_novo = caso1 (Z_barra, Z_novo)
a = length(Z_barra);
if a == 0
    Z_barra = Z_novo;
    Z_barra_novo = Z_barra;
else
    Z_barra (a+1, a+1) = Z_novo;
    Z_barra_novo = Z_barra;
end
end