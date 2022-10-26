% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'perdasGauss'
% O OBJETIVO DA  FUNÇÃO É CALCULAR AS PERDAS NAS LINHAS DO SISTEMA
% 
% _________________________________________________________________________
% Sintaxe: Dados_barras ->(entrada) Dados com 1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu  
%          Dados_linha  ->(entrada)   N°Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite
%          linha_cont   ->(entrada) número da linha contingenciada
%          operador     ->(entrada) operador para selecionar se a operação
%          é de retirada de linha ou adição
%          Pperdas        ->(saída)Perdas nas linhas 


function [Pperdas]=perdasGauss(Dados_linha,Vn,linha_cont,operador)
n_linhas = length(Dados_linha(:,1));
P = zeros(n_linhas,n_linhas);
V = abs(Vn);
Ybm=Ybarra_insp(Dados_linha);

%% modificação para reforço de linhas
if operador==1
    Zbo=pinv(Ybm);
    addimped=Dados_linha(linha_cont,5)+i*Dados_linha(linha_cont,6);
    barra_des=Dados_linha(linha_cont,3);
    barra_ori=Dados_linha(linha_cont,2);
    Zbo=caso4(Zbo,addimped,barra_des,barra_ori);
    Ybm=pinv(Zbo);
end

%% calculos de perdas
Y = abs(Ybm);
Ang = angle(Ybm);
delta = angle(Vn);
de = Dados_linha(:,2);
para = Dados_linha(:,3);
Pperdas = 0;
for n=1:n_linhas
    P(de(n),para(n))= - ((V(de(n)))^2)*(Y(de(n),para(n)))*cos(Ang(de(n),para(n))) + (V(de(n)))*(V(para(n)))*(Y(de(n),para(n)))*cos(Ang(de(n),para(n)) - delta(de(n)) + delta(para(n)));
    P(para(n),de(n))= - ((V(para(n)))^2)*(Y(de(n),para(n)))*cos(Ang(de(n),para(n))) + (V(de(n)))*(V(para(n)))*(Y(de(n),para(n)))*cos(Ang(de(n),para(n)) - delta(para(n)) + delta(de(n)));
    P_gauss(de(n),para(n))= P(de(n),para(n)) + P(para(n),de(n));
    P_linha(n,1)=P_gauss(de(n),para(n))*100000;
    if (P_gauss(de(n),para(n)) ~= 0)
        Pperdas = Pperdas + P_gauss(de(n),para(n));
    end
end
Pperdas = Pperdas*100000;

end