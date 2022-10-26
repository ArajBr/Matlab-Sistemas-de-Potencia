% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'contingencia'
% O OBJETIVO DA  FUNÇÃO É REALIZAR OS CALCULOS EM DECORRENCIA DE UMA DADA
% CONTINGENCIA
% _________________________________________________________________________
% Sintaxe: Dados_barras ->(entrada) Dados com 1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu  
%          Dados_linha  ->(entrada)   N°Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite
%          linha_cont   ->(entrada) número da linha contingenciada
%          operador     ->(entrada) operador para selecionar se a operação
%          é de retirada de linha ou adição
%          V              ->(saída)Tensão nas barras antes da contingencia
%          Vn             ->(saída)Tensão nas barras depois da contingencia
%          Inovo          ->(saída)Corrente nas linhas depois da contingencia
%          Ilinha         ->(saída)Corrente nas linhas antes da contingencia
%          P_linha_cont   ->(saída)Perdas nas linhas pós contingencia
%          P_linha        ->(saída)Perdas nas linhas pré contingencia
%          do Gauss Seidel
%          Ordem_crit     ->(saída)matriz com as linhas em ordem
%          descendente das linhas mais criticas na primeira coluna, Ilinha
%          na segunda coluna, Inovo na terceira coluna
%          L              ->(saída)Matriz L
function [Inovo,Vn,Ilinha,V,P_linha,P_linha_cont,Ordem_crit,L]= contingencia(Dados_barras,Dados_linha,linha_cont,operador)

n_matriz=1;
[ResultadoGauss] = Gauss_Seidel(Dados_barras,Dados_linha,n_matriz,operador);
zb=Dados_barras(:,1); %vetor de de barras
nB=max(max(Dados_linha(:,2)),max(Dados_linha(:,3)));%tamanho do vetor de barras do sistema
de=Dados_linha(:,2);
para=Dados_linha(:,3);
maxlinha=max(max(Dados_linha(:,1)));
imp=Dados_linha(:,5)+i*Dados_linha(:,6);
Ybm=Ybarra_insp(Dados_linha);
Zbo=pinv(Ybm);

%% modificação para reforço de linhas
if operador==1
    addimped=Dados_linha(linha_cont,5)+i*Dados_linha(linha_cont,6);
    barra_des=Dados_linha(linha_cont,3);
    barra_ori=Dados_linha(linha_cont,2);
    Zbo=caso4(Zbo,addimped,barra_des,barra_ori);
    Ybm=pinv(Zbo);
end

%% linha que se deseja remover
aux1=Dados_linha(linha_cont,2);
aux2=Dados_linha(linha_cont,3);

for m=1:maxlinha   %acha a impedâcia entre as barras
    if de(m,1)==aux1 && para(m,1)==aux2
        imped=-imp(m,1);
        posi=m;
    end
end

V=ResultadoGauss(:,4);
%teta=ResultadoGauss(:,4);
%% A matriz elemento nó
A=zeros(1,aux1);
for k=1:nB
    if k==aux1
        A(1,k)=1;
    else
        A(1,k)=0;
    end
    if k==aux2
        A(1,k)=-1;
    end
end


Zl=i*imped+(A*Zbo*A');% A matriz Z Laço
Ic=(inv(Zl))*(A*V);% Corrente Compensatória
DV=(Zbo*A'*Ic);   % Delta das tensões das barras
Vn=V+DV;          % As tensões após a remoção da linha

%% Cálculo das Correntes antes da remoção da linha
Ilinha=zeros(maxlinha,1); %corrente antes da remoção
for k=1:maxlinha
    aux3=de(k,1);
    aux4=para(k,1);
    Ilinha(k,1)=(V(aux3)-V(aux4))/(1i*imp(k,1));
end
Ilinha=Ilinha*100000;
%% Os fatores  L e K
L=zeros(maxlinha,1); %Inicializa o fator de distribuição L
K=zeros(maxlinha,1); %Inicializa o fator de distribuição K
for k=1:maxlinha %Cálculo do fator L
    num1=(Zbo(aux1,de(k,1))-Zbo(aux1,para(k,1))); %Zpm-Zpn
    num2=(Zbo(aux2,de(k,1))-Zbo(aux2,para(k,1))); %Zqm-Zqn
    Th=(Zbo(aux1,aux1))+(Zbo(aux2,aux2))-(Zbo(aux1,aux2))-(Zbo(aux2,aux1)); %Equivalente de Thévenin entre mn
    aux5=(num1-num2)/(Th-(1i*imped));
    L(k,1)=-((1i*imped)/(1i*imp(k,1)))*aux5;
    L(k,2)=k;
end

%% Fator K
for j=1:nB
    K(j,1)=((Zbo(aux1,j))-Zbo(aux2,j))/1i*imped;
end

norma=max(abs(K));
K=K/norma;
K;
%% Variação das correntes(DELTA I)
Di=zeros(aux2,1);
for k=1:maxlinha
    if de(k,1)~=0
        Di(k,1)=Ilinha(k,1)*L(k,1);
    else
        Di(k,1)=0;
    end
end

%% Calculo das novas correntes de barras
Inovo=zeros(maxlinha,1);
for k=1:maxlinha
    Inovo(k,1)=Ilinha(k,1)+Di(k,1);
end
[P_linha]=perdasGauss(Dados_linha,V,linha_cont,operador);
[P_linha_cont]=perdasGauss(Dados_linha,Vn,linha_cont,operador);

% [perdasI]=perdasCorrente(Ilinha,Dados_linha);
%
% [perdasII]=perdasCorrente(Inovo1,Dados_linha);

%% Ordem de criticidade das linhas
Ordem_crit=L;
for k=1:maxlinha
    Ordem_crit(k,3)=abs(Ilinha(k));
    Ordem_crit(k,4)=abs(Inovo(k));
end
Ordem_crit = sortrows(Ordem_crit);
Ordem_crit=flipud(Ordem_crit);
Ordem_crit(:,1)=[];


end