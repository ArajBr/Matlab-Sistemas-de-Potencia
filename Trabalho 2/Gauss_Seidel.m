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
function [ResultadoGauss,Correntes,perdasGauss] = Gauss_Seidel(Dados_barras,Dados_linha,n_matriz)

[Ybarra]=Ybarra_insp(Dados_linha);

n_barras = max(max(Dados_linha(:,2)),max(Dados_linha(:,3)));
n_linhas = length(Dados_linha(:,1));

total_de_barras=n_barras;
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
PL = (PG-PC)./1000;
QL = (QG-QC)./1000;
tol=1;
iter=0;
e=0.00001;
alfa=1.6;

while tol > e
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
%-----------------------corrente nas linhas----------------------------%

for l = 1:n_linhas
    i = Dados_linha(l,2);
    k = Dados_linha(l,3);
    I(:,l) = Ybarra(i,k)*(V(i)-V(k));
end
I=I';

for k = 1:n_linhas
    I(k) = I(k)*230;
    if abs(I(k))>Dados_linha(k,7)
        Z(k,:) = '     Acima';
    end
    if abs(I(k))<Dados_linha(k,7)
        Z(k,:)='     Ok   ';
    end
end
ZZ='.   .';
Istr=num2str(abs(I));
Correntes = strcat(ZZ,Istr,Z);



%%CALCULO DE PERDAS
Ymod=abs(Ybarra);
Theta=(angle(Ybarra));
Vmod=abs(V);
Vtheta=(angle(V));

%%Perdas ativas
for l = 1:n_linhas
    i = Dados_linha(l,2);
    k = Dados_linha(l,3);
    Pperdas_ik(i)=-Vmod(i)^2*Ymod(i,k)*cos(Theta(i,k))+Vmod(i)*Vmod(k)*cos(Theta(i,k)-Vtheta(i)+Vtheta(k));
    Pperdas_ki(i)=-Vmod(k)^2*Ymod(k,i)*cos(Theta(k,i))+Vmod(k)*Vmod(i)*cos(Theta(k,i)-Vtheta(k)+Vtheta(i));
end
perdasGauss=(Pperdas_ik'-Pperdas_ki')*6.2343/n_matriz;
perdasGauss=sum(perdasGauss);
%disp(sum(Pperdas));
%
% for l = 1:n_linhas
%         i = Dados_linha(l,2);
%         k = Dados_linha(l,3);
%         Qperdas_ik(i)=Vmod(i)^2*Ymod(i,k)*sin(Theta(i,k))-Vmod(i)*Vmod(k)*sin(Theta(i,k)-Vtheta(i)+Vtheta(k));
%         Qperdas_ki(i)=Vmod(k)^2*Ymod(k,i)*sin(Theta(k,i))-Vmod(k)*Vmod(i)*sin(Theta(k,i)-Vtheta(k)+Vtheta(i));
% end
%
% Qperdas=(Qperdas_ik-Qperdas_ki);
% disp(sum(Qperdas));

ResultadoGauss(1:total_de_barras,1)=Dados_barras(:,1);
ResultadoGauss(1:total_de_barras,2)=Dados_barras(:,2);
ResultadoGauss(1:total_de_barras,3)=real(Dados_barras(:,3));
ResultadoGauss(1:total_de_barras,4)=radtodeg(angle(V));
if n_matriz == 1
    ResultadoGauss(1:total_de_barras,5)=23*0.95;
    ResultadoGauss(1:total_de_barras,6)=23*1.05;
end
if n_matriz == 2
    ResultadoGauss(1:total_de_barras,5)=11*0.95;
    ResultadoGauss(1:total_de_barras,6)=11*1.05;
end

end