clear all;
clc;

variavel_ex=0;
variavel_ex2=0;
while i < 1
    x=menu('Representa??o de Redes El?tricas',...
        'SELE??O DOS DADOS DE ENTRADA',...
        'GAUSS-SEIDEL',...
        'FLUXO LINEARIZADO',...
        'SAIR');
    
    switch x
        case 1
            y=menu('Leitura dos dados de entrada','Dados 1','Dados 2');
            switch y
                case 1
                    %1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu   
                    Dados_barras=[
                        1      1	23  	0	0	0   0       0       0	0;
                        2      3	23  	0	0	0	1840	460     0	0;
                        3      3	23  	0	0	0	980     340     0	0;
                        4      3	23  	0	0	0	1790	446     0	0;
                        5      3	23  	0	0	0	1598	1840	0	0;
                        6      3	23  	0	0	0	1610	600     0	0;
                        7      3	23  	0	0	0	780     110     0	0;
                        8      3	23  	0	0	0	1150	60      0	0;
                        9      3	23  	0	0	0	980     130     0	0;
                        10     3	23  	0	0	0	1640	200     0	0];
                    
                    
                    Dados_linha=[
                        1	1	2	0	0.1233		0.4127		130;
                        2	2	3	0	0.0140		0.6051		80;
                        3	3	4	0	0.7463		1.2050		65;
                        4	4	5	0	0.6984		0.6084		65;
                        5	5	6	0	1.9831		1.7276		65;
                        6	6	7	0	0.9053		0.7886		65;
                        7	7	8	0	2.0552		1.1640		130;
                        8	8	9	0	4.7953		2.7160		65;
                        9	9	10	0	5.3434		3.0264		65];
                    variavel_ex=1;
                    n_matriz=1;
                    disp('*****************************************MATRIZ SELECIONADA*************************************************************');
                    disp('N? de barras        Tipo       Tens?o      Theta          Pg          Qg         Pc          Qc         Vmax        Vmin')
                    disp(Dados_barras)
                    disp('************************************************************************************************************************');
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp('          N?Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite')
                    disp(Dados_linha)
                    disp('********************************************************************************************************');
                
                case 2
                    %1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu   9.Qmin	10.Qmax	11.Vmin	12.Vmax
                    Dados_barras=[
                        1 1 11 0 0 0 0 0;
                        2 3 11 0 0 0 230 142.500000000000;
                        3 3 11 0 0 0 0 0;
                        4 3 11 0 0 0 230 142.500000000000;
                        5 3 11 0 0 0 230 142.500000000000;
                        6 3 11 0 0 0 0 0;
                        7 3 11 0 0 0 0 0;
                        8 3 11 0 0 0 230 142.500000000000;
                        9 3 11 0 0 0 230 142.500000000000;
                        10 3 11 0 0 0 0 0;
                        11 3 11 0 0 0 230 142.500000000000;
                        12 3 11 0 0 0 137 84;
                        13 3 11 0 0 0 72 45;
                        14 3 11 0 0 0 72 45;
                        15 3 11 0 0 0 72 45;
                        16 3 11 0 0 0 13.5000000000000 7.50000000000000;
                        17 3 11 0 0 0 230 142.500000000000;
                        18 3 11 0 0 0 230 142.500000000000;
                        19 3 11 0 0 0 230 142.500000000000;
                        20 3 11 0 0 0 230 142.500000000000;
                        21 3 11 0 0 0 230 142.500000000000;
                        22 3 11 0 0 0 230 142.500000000000;
                        23 3 11 0 0 0 230 142.500000000000;
                        24 3 11 0 0 0 230 142.500000000000;
                        25 3 11 0 0 0 230 142.500000000000;
                        26 3 11 0 0 0 230 142.500000000000;
                        27 3 11 0 0 0 137 85;
                        28 3 11 0 0 0 75 48;
                        29 3 11 0 0 0 75 48;
                        30 3 11 0 0 0 75 48;
                        31 3 11 0 0 0 57 37.5000000000000;
                        32 3 11 0 0 0 57 37.5000000000000;
                        33 3 11 0 0 0 57 37.5000000000000;
                        34 3 11 0 0 0 57 37.5000000000000];
                    %1.n?linha 2.PG 3.QG 4.PL 5.QL 6.V 7.Angulo
                    
                    
                    Dados_linha=[
                        1	1	2	0	0.195		0.0800		0.60		100;
                        2	2	3	0	0.195		0.0800		0.55		100;
                        3	3	4	0	0.2990		0.0830		0.55		100;
                        4	4	5	0	0.2990		0.0830		0.50		100;
                        5	5	6	0	0.2990		0.0830		0.50		100;
                        6	6	7	0	0.5240		0.0900		0.60		100;
                        7	7	8	0	0.5240		0.0900		0.40		100;
                        8	8	9	0	0.5240		0.0900		0.60		100;
                        9	9	10	0	0.5240		0.0900		0.40		100;
                        10	10	11	0	0.5240		0.0900		0.25		100;
                        11	11	12	0	0.5240		0.0900		0.20		65;
                        12	3	13	0	0.5240		0.0900		0.30		80;
                        13	13	14	0	0.5240		0.0900		0.40		65;
                        14	14	15	0	0.5240		0.0900		0.20		65;
                        15	15	16	0	0.2990		0.0900		0.10		130;
                        16	6	17	0	0.2990		0.0830		0.60		130;
                        17	17	18	0	0.3780		0.0830		0.55		130;
                        18	18	19	0	0.3780		0.0860		0.55		65;
                        19	19	20	0	0.3780		0.0860		0.50		80;
                        20	20	21	0	0.5240		0.0860		0.50		65;
                        21	21	22	0	0.5240		0.0900		0.50		65;
                        22	22	23	0	0.5240		0.0900		0.50		130;
                        23	23	24	0	0.5240		0.0900		0.60		130;
                        24	24	25	0	0.5240		0.0900		0.40		65;
                        25	25	26	0	0.5240		0.0900		0.25		80;
                        26	26	27	0	0.5240		0.0900		0.20		65;
                        27	7	28	0	0.5240		0.0900		0.30		65;
                        28	28	29	0	0.5240		0.0900		0.30		130;
                        29	29	30	0	0.5240		0.0900		0.30		130;
                        30	10	31	0	0.5240		0.0900		0.30		65;
                        31	31	32	0	0.5240		0.0900		0.40		65;
                        32	32	33	0	0.5240		0.0900		0.30		130;
                        33	33	34	0	0.5240		0.0900		0.20		130];
                    %tratamento dos dados, j? que as impedancias s?o dadas
                    %por Km
                    Dados_linha(:,5)=Dados_linha(:,5).*Dados_linha(:,7);
                    Dados_linha(:,6)=Dados_linha(:,6).*Dados_linha(:,7);
                    Dados_linha(:,7)=Dados_linha(:,8);
                    Dados_linha(:,8)=[];
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp(Dados_barras)
                    disp('********************************************************************************************************');
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp('          N?Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite')
                    disp(Dados_linha)
                    disp('********************************************************************************************************');
                
                    variavel_ex=1;
                    n_matriz=2;
            end
        case 2
            clc
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
            if variavel_ex==1
                [ResultadoGauss,correntes,perdasGauss] = Gauss_Seidel(Dados_barras,Dados_linha,n_matriz);
                disp('*******************************************************************************');
                disp('         |Barra No.|  |Tipo|  |Tens?o(KV)|    |?ngulo|  |Vmin(KV)|   |Vmax(KV)|');
                disp('*******************************************************************************');
                disp(ResultadoGauss);
                disp('*******************************************************************************');
                disp('     |I(A)|      LIMITE');
                disp('*******************************************************************************');
                disp(correntes)
                disp('*******************************************************************************');
                variavel_ex2=1;
            end
        case 3
            clc
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
            if variavel_ex==1
                if variavel_ex2==0
                    disp('Execute o Gauss-Seidel');
                else
                    [perdas]= Linearizado(Dados_linha,Dados_barras,n_matriz);
                    disp('******************************')
                    disp('Perdas no do fluxo linearizado')
                    disp('******************************')
                    disp(perdas)
                    disp('******************************')
                    disp('Perdas no do Gauss-Seidel')
                    disp('******************************')
                    disp(perdasGauss)
                    disp('******************************')
                end
            end
        case 4
            i=2;
    end
end