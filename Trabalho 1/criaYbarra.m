function [Y_barra] = criaYbarra(sep)
grafo=sep(:,1:2);                                 %% duas primeiras colunas do input, correspondendo aos nós de partida e chegada
menor = min(sep(:,1));                            %% tratamento da referencia  igual a 0, para igual 1, devido aos indices utilizados na matriz de incidencia
if menor ==0
    grafo = sep(:,1:2)+1;
end
[z_primitiva]=ZPRIMITIVA(sep);
A = MatrizIncidencia(grafo(:,1:2));
Ared = A(1:rank(A),:);                             %%Cria incidencia reduzida
y_primitiva=inv(z_primitiva);
Y_barra=Ared*y_primitiva*Ared';                    %% matriz de admitancias Y barra
end