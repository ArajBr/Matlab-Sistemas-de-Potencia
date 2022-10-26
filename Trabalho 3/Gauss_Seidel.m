% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________
%  'Gauss_Seidel'
% O OBJETIVO DA  FUNÇÃO É REALIZAR O CALCULO DO FLUXO DE POTÊNCIA
% ATRAVÉS DO MÉTODO DE GAUSS SEIDEL.
% _________________________________________________________________________
% Sintaxe: Dados_barras ->(entrada) Dados com 1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu  
%          Dados_linha  ->(entrada)   N°Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite
%          ResultadoGauss ->(saída)  |Barra No.|  |Tipo|  |Tensão(KV)|    |Ângulo|  |Vmin(KV)|   |Vmax(KV)|
%          correntes      ->(saída)   |I(A)|      I_LIMITE
%          perdasGauss    ->(saída)  variável com as perdas ativas atraves
%          do Gauss Seidel
function [ResultadoGauss] = Gauss_Seidel(Dados_barras,Dados_linha,linha_cont,operador)

[Ybarra]=Ybarra_insp(Dados_linha);

n_barras = max(max(Dados_linha(:,2)),max(Dados_linha(:,3)));
n_linhas = length(Dados_linha(:,1));

total_de_barras=n_barras;

%% modificação para reforço de linhas
if operador==1
    Zbo=pinv(Ybarra);
    addimped=Dados_linha(linha_cont,5)+j*Dados_linha(linha_cont,6);
    barra_des=Dados_linha(linha_cont,3);
    barra_ori=Dados_linha(linha_cont,2);
    Zbo=caso4(Zbo,addimped,barra_des,barra_ori);
    Ybarra=pinv(Zbo);
end

%% calculo do Gauss Seidel
Ybarra;
ResultadoGauss=zeros(total_de_barras,5);
n_barra=Dados_barras(:,1);
PG=Dados_barras(:,5);
QG=Dados_barras(:,6);
PC=Dados_barras(:,7);
QC=Dados_barras(:,8);
V=Dados_barras(:,3);

V_ant=V;
ANG=Dados_barras(:,4);
tipo = Dados_barras(:,2);
PL = (PG-PC)./100000;
QL = (QG-QC)./100000;
tol=1;
iter=0;
e=0.00000001;
alfa=1.6;

while tol > e
%while iter < 100
    for i = 2:total_de_barras
        YV = 0;
        for k = 1:total_de_barras
            if i~=k
                YV = YV + Ybarra(i,k)* V(k);  % multiplicando admitancias e tensoes
            end
            YV;
        end
        if Dados_barras(i,2) == 2     %Calculo de Qi nas barras PV
            QL(i) =  -imag(conj(V(i))*(YV + Ybarra(i,i)*V(i)));
            Dados_barras(i,6)=QL(i);
        end
        if Dados_barras(i,2) == 2
            ResultadoGauss(i,6)=(QL(i)*100)+Dados_barras(i,8);
        end
        
        V(i) = (1/Ybarra(i,i))*((PL(i)-j*QL(i))/conj(V(i)) - YV); % Calculo das tensôes nas barras.
        % Calculo corrigido nas barras PV
        if Dados_barras(i,2) == 2
            vc(i)=abs(V_ant(i))*(V(i)/abs(V(i)));
            Dados_barras(i,3)=vc(i);
            V(i)=vc(i);
        end
        % Calculo da tensão acelerada nas barras PQ
        if Dados_barras(i,2) == 3
            VACC(i)= V_ant(i)+alfa*(V(i)-V_ant(i));
            Dados_barras(i,3)=VACC(i);
            V(i)=VACC(i);
        end
        
    end
    iter = iter + 1;
    tol = max(abs(abs(V(2:n_barras)) - abs(V_ant(2:n_barras))));     % Calculo da tolerancia.
    V_ant = V;
end
iter;
YV;
V;
ResultadoGauss(1:total_de_barras,1)=Dados_barras(:,1);
ResultadoGauss(1:total_de_barras,2)=Dados_barras(:,2);
ResultadoGauss(1:total_de_barras,3)=real(Dados_barras(:,3))/23;
%ResultadoGauss(1:total_de_barras,4)=radtodeg(angle(V));
ResultadoGauss(1:total_de_barras,4)=V;



end