% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JO�O MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'Ybarra_insp'
%  Esta fun��o contr�i a matriz Ybarra de um determinado sep utilizando o
% m�todo de inspe��o. 
% 
% barras = s�o os dados das colunas 2 e 3 da matriz Dados_linha que tr�s a 
%informa��o de qual elemento conecta quais barras.
% Cada linha representa uma barra, esta matriz deve ser constru�da de
% maneira tal que a linha 1 seja sempre referente � barra de refer�ncia.
% Cada coluna representa um dos elementos do sep. Desta forma sempre que um
% determinado elemento � conectado � uma determinada barra a matriz deve
% receber o valor 1 nesta posi��o e sempre que n�o houver conex�o entre um
% determinado elemento e uma barra a matriz deve receber zero nesta
% posi��o. Pode ser, tamb�m, a matriz de elemento-n� (A) desde que
% constru�da incluindo a barra de refer�ncia.
% _________________________________________________________________________
% Sintaxe: Ybarra -> (saida) MATRIZ Y BARRA MONTADA POR INSPE�AO
%          Dados_linha -> (entrada) MATRIZ COM OS DADOS DAS LINHAS
function [Ybarra]=Ybarra_insp(Dados_linha)


n_barras = max(max(Dados_linha(:,2)),max(Dados_linha(:,3)));
n_linhas = length(Dados_linha(:,1));
for i=1:n_linhas
    y(i)=inv(Dados_linha(i,5)+j*Dados_linha(i,6));
end
Ybarra = zeros(n_barras,n_barras);

for b=1:n_linhas
    Ybarra((Dados_linha(b,2)),(Dados_linha(b,3)))=-y(b);
    Ybarra((Dados_linha(b,3)),(Dados_linha(b,2))) =Ybarra((Dados_linha(b,2)),(Dados_linha(b,3)));
    
end
for c=1:n_barras
    for d=1:n_linhas
        if Dados_linha(d,2) == c || Dados_linha(d,3) == c
            Ybarra(c,c) = Ybarra(c,c) + y(d) ;
        end
    end
end
end