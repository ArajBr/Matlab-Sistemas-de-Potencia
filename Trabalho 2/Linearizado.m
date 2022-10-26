% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JO�O MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'Linearizado'
%FUN��O UTILIZADA PARA CALCULAR OS �NGULOS THETA PELO M�TODO LINEARIZADO. A
%FUN��O T�M COMO PAR�METROS DE ENTRADA O VETOR DE BARRAS DE ORIGEM, BARRAS
%DE DESTINO, O N�MERO DE LINHAS E A REAT�NCIA S�RIE.
%__________________________________________________________________________
% Sintaxe: Dados_barras ->(entrada) Dados com 1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu  
%          Dados_linha  ->(entrada)   N�Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite
%          n_matriz     ->(entrada) numero da matriz que foi utilizada
%          Perdas         ->(sa�da) perdas referentes ao metodo linearizado
%          

function [Perdas]= Linearizado(Dados_linha,Dados_barras,n_matriz)
[Ybarra]=Ybarra_insp(Dados_linha);
n_barras = length(Dados_barras(:,1));            %N�mero de barras do sistema
P_liq = Dados_barras(:,7)/1000;
P_liq(1,:)=[];
barra_origem=Dados_linha(:,2);
barra_destino=Dados_linha(:,3);
n_Dados_linha=max(Dados_linha(:,1));

for i = 1:n_Dados_linha
    for k=1:2
        Dados_linha(i,k) = Dados_linha(i,k+1);
    end
end
[n_linhas,coluna] = size(Dados_linha);
n_barras = max(max(Dados_linha(:,1:2)));
perdas = zeros(n_barras,n_barras);

%Constru��o matriz B'
B=zeros(n_barras,n_barras);
B=-imag(Ybarra);
B(1,:) = [];
B(:,1) = [];

%Calculo do theta temporario
theta_temp = inv(B)*P_liq;
theta_temp = [0;theta_temp];

%� inicializada uma matriz de perdas
perdas = zeros(n_barras,1); 
tolerancia = 0.0001;
erro = 1;
ite=0;
while(tolerancia <= erro && ite<50)
    for i=1:n_linhas
        a = barra_origem(i); %a variavel a recebe o indice da barra que sai a linha
        b = barra_destino(i); %a variavel b recebe o indice da barra que entra a linha
        r = Dados_linha(i,5); %a variavel R recebe o indice da impedancia da linha
        z = Dados_linha(i,6);%a variavel Z recebe o indice da impedancia da linha
        zt = (r^2 + z^2); % zt � utilizado para facilitar no calculo
        tet = (theta_temp(b,1)-theta_temp(a,1))/1000; % tet � utilizado para facilitar no calculo
        %� montada uma matriz com as perdas
        perdas(a,1) = perdas(a,1) + ((r/zt)*(tet^2))/2;
        perdas(b,1) = perdas(b,1) + ((r/zt)*(tet^2))/2;
    end
    perdas;
    for i=1:n_barras-1
        %Uma nova matriz P � calculada considerando as perdas
        P_liq(i,1) = P_liq(i,1) - perdas(i+1,1);
    end
    teta = inv(B)*P_liq; %Os novos tetas s�o calculados
    teta = [0;teta];
    erro = max(abs(theta_temp - teta));%calculo do erro
    theta_temp=teta;
    ite=ite+1;
    end
Perdas=sum(teta)/n_matriz;