% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'Caso4'
% O OBJETIVO DA  FUNÇÃO É ADICIONAR UMA LINHA ENTRE DUAS BARRAS EXISTENTES
% NA MATRIZ ZBARRA
% _________________________________________________________________________
% Adição de Zb entre duas barras existentes (k) e (j)
% b_k -> barra k (Origem)
% b_j -> barra j (Destino)

function Z_barra_novo = caso4 (Z_barra, Z_novo, b_k, b_j)
a = length(Z_barra);
for n = 1:a
    Z_barra(n,a+1) = Z_barra(n,b_j)-Z_barra(n,b_k);
    Z_barra(a+1,n) = Z_barra(b_j,n)-Z_barra(b_k,n);
    Z_barra(a+1,a+1) = (Z_barra(b_j,b_j)+Z_barra(b_k,b_k)-(2*Z_barra(b_j,b_k))+Z_novo);
    Z_barra_novo = Z_barra;
end
Z_barra_novo = Reducao_kron (Z_barra_novo, a+1);
end