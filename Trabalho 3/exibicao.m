% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'exibicao'
% O OBJETIVO DA  FUNÇÃO É AGLUTINAR OS DADOS OBTIDOS PARA FACILITAR A
% EXIBIÇÃO NA FUNÇÃO PRINCIPAL
% _________________________________________________________________________
% Sintaxe: Dados_barras ->(entrada) Dados com 1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu
%          Dados_linha  ->(entrada)   N°Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite
%          n_matriz     ->(entrada) número da matriz utilizada
%          operador     ->(entrada) operador para selecionar se a operação
%          é de retirada de linha ou adição
%          perdas       ->(saída)Perdas nas linhas antes e depois da contingencia

function [comparacao,comparacao2,perdas]=exibicao(Dados_linha,Dados_barras,n_matriz,operador)
a=0;

% para execução do codigo Gauss_Seidel sem apresentar grandes problemas na
% analise de contingencias, não podem haver ilhamentos, logo estes casos
% devem ser excluidos

if n_matriz == 1
    ilhamento = 9;
end
if n_matriz == 2
    ilhamento = 1;
end

%% etapa para calculo de perdas para cada caso de contingencia
for i = 1:1:16
    if i~=ilhamento
        linha_cont=i;
        [Inovo,Vn,Ilinha,V,Pperdas,P_linha_cont,Critica]= contingencia(Dados_barras,Dados_linha,linha_cont,operador);
        extrapola(i,1)=max(abs(Inovo))/1000;
        extrapola(i,2)=max(abs(Vn));
        extrapola(i,3)=i;
        extrapola(i,4)=sum(Pperdas);
        extrapola(i,5)=sum(P_linha_cont);
    end
end
extrapola;
%% selecionando como caso mais critico o com maiores perdas
extrapola = sortrows(extrapola,5);
extrapola = flipud(extrapola);
linha_cont=extrapola(1,3);

%% vetor para comparação de resultados no programa principal
if n_matriz==1
    x=1;
end
if n_matriz==2
    x=100;
end


[Inovo,Vn,Ilinha,V,Pperdas,P_linha_cont,Critica]= contingencia(Dados_barras,Dados_linha,linha_cont,operador);
comparacao(:,1)=real(V);
comparacao(:,2)=(rad2deg(angle(V)))*x;
comparacao(:,3)=real(Vn);
comparacao(:,4)=(rad2deg(angle(Vn)))*x;
comparacao2=Critica;
perdas=Pperdas;
perdas(:,2)=P_linha_cont;
perdas=perdas*x;
% disp(comparacao)
% disp(comparacao2)
end