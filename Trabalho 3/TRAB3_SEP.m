% UNIVERSIDADE FERERAL DE OUTRO PRETO - CAMPUS JOÃO MONLEVADE
%          ALEXANDRE RODRIGUES ALVES JUNIOR 13.2.8389
%              SEP II     TRABALHO 2      CEA 583
% _________________________________________________________________________

clear all;
clc;

variavel_ex=0;
variavel_ex2=0;
comparacao2=0;
operador=0;
while i < 1
    x=menu('Representação de Redes Elétricas',...
        'SELECIONE O SISTEMA',...
        'GRAFO DO SISTEMA SELECIONADO',...
        'COMPARAÇÂO DE TENSÕES CASO MAIS CRÍTICO',...
        'COMPARAÇÂO DE CORRENTES CASO MAIS CRÍTICO',...
        'COMPARAÇÂO DE TENSÕES LINHA REFORÇADA',...
        'COMPARAÇÂO DE CORRENTES LINHA REFORÇADA',...
        'SAIR');
    
    switch x
        case 1
            y=menu('Leitura dos dados de entrada','Dados 1','Dados 2');
            switch y
                case 1
                    %1.barras  2.tipo	3.tensao  4.teta 	5.Pgera	6.Qgera	 7.Pconsu	8.Qconsu
                    Dados_linha = [1     14      13   0    7.50    10.00
                        2   13      12    0   8.00    11.00
                        3   13      11    0   9.00    18.00
                        4   11      10    0   4.00     4.00
                        5   14       9    0  11.00    11.00
                        6    9       8    0   8.00    11.00
                        7    9       7    0  11.00    11.00
                        8    8       6    0  11.00    11.00
                        9    8       5    0   8.00    11.00
                        10   14       4   0   11.00    11.00
                        11    4       3   0    9.00    12.00
                        12    4       2   0    8.00    11.00
                        13    2       1   0    4.00     4.00
                        14   12       6   0    4.00     4.00
                        15    7       3   0    4.00     4.00
                        16   10       1   0    9.00    12.00 ];
                    
                    Dados_barras = [14  1 23 0 0 0       0.0     0.0
                        13  3 23 0 0 0      2000.0  1600.0
                        12  3 23 0 0 1100.0 3000.0  1500.0
                        11  3 23 0 0 1200.0 2000.0   800.0
                        10  3 23 0 0 0      1500.0  1200.0
                        9  3 23 0 0 0      4000.0  2700.0
                        8  3 23 0 0 1200.0 5000.0  3000.0
                        7  3 23 0 0 0      1000.0   900.0
                        6  3 23 0 0 600.0  600.0   100.0
                        5  3 23 0 0 3700.0 4500.0  2000.0
                        4  3 23 0 0 0      1000.0   900.0
                        3  3 23 0 0 1800.0 1000.0   700.0
                        2  3 23 0 0 0      1000.0   900.0
                        1  3 23 0 0 1800.0 2100.0  1000.0   ];
                    variavel_ex=1;
                    n_matriz=1;
                    disp('*****************************************MATRIZ SELECIONADA*************************************************************');
                    disp('N° de barras        Tipo       Tensão      Theta          Pg          Qg         Pc          Qc         Vmax        Vmin')
                    disp(Dados_barras)
                    disp('************************************************************************************************************************');
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp('   N°Linha   Barra Ori Barra Dest   z/y       r        x        Ilimite')
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
                    %1.n°linha 2.PG 3.QG 4.PL 5.QL 6.V 7.Angulo
                    
                    
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
                    %tratamento dos dados, já que as impedancias são dadas
                    %por Km
                    Dados_linha(:,5)=Dados_linha(:,5).*Dados_linha(:,7);
                    Dados_linha(:,6)=Dados_linha(:,6).*Dados_linha(:,7);
                    Dados_linha(:,7)=Dados_linha(:,8);
                    Dados_linha(:,8)=[];
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp(Dados_barras)
                    disp('********************************************************************************************************');
                    disp('*****************************************MATRIZ SELECIONADA*********************************************');
                    disp('          N°Linha   Barra Origem   Barra Destino   z/y       r            x        Ilimite')
                    disp(Dados_linha)
                    disp('********************************************************************************************************');
                    
                    variavel_ex=1;
                    n_matriz=2;
            end
        case 2
            clc;
            if variavel_ex==1
                [h]=desenhaGrafo(Dados_linha);
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
        case 3
            clc;
            if variavel_ex==1
                [comparacao,comparacao2,perdas]=exibicao(Dados_linha,Dados_barras,n_matriz,operador);
                disp('***********************************************');
                disp('    V          Ang(°)   Vfalta    Angfalta(°)')
                disp('***********************************************');
                disp(comparacao)
                disp('************************************************************');
                disp('PERDAS DO SISTEMA COMPLETO E PERDAS SISTEMA COM CONTINGÊNCIA')
                disp(perdas)
                variavel_ex2==1;
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
        case 4
            clc;
            if variavel_ex==1 
                [comparacao,comparacao2,perdas]=exibicao(Dados_linha,Dados_barras,n_matriz,operador);
                disp('*******************************************************************************************');
                disp('LINHAS ORDENADAS, SEGUNDO O CRITÉRIO DA MATRIZ L, DA MAIS CRÍTICA PARA DE MENOR CRITICIDADE')
                disp('*******************************************************************************************');
                disp('Criticidade  |I|      |I N-1|')
                disp('***********************************************');
                disp(comparacao2)
                disp('************************************************************');
                disp('PERDAS DO SISTEMA COMPLETO E PERDAS SISTEMA COM CONTINGÊNCIA')
                disp(perdas)
            end
            if variavel_ex==0 && variavel_ex2==0
                disp('Escolha um conjunto de dados');
            end
        case 5
            clc;
            if variavel_ex==1
                operador=1;
                [comparacao,comparacao2,perdas]=exibicao(Dados_linha,Dados_barras,n_matriz,operador);
                disp('***********************************************');
                disp('    V          Ang(°)   Vfalta    Angfalta(°)')
                disp('***********************************************');
                disp(comparacao)
                disp('************************************************************');
                disp('PERDAS DO SISTEMA COMPLETO E PERDAS SISTEMA COM CONTINGÊNCIA,APÓS O REFORÇO')
                disp(perdas)
                variavel_ex2==1;
                operador=0;
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
            
        case 6
            clc;
            if variavel_ex==1
                operador=1;
                [comparacao,comparacao2,perdas]=exibicao(Dados_linha,Dados_barras,n_matriz,operador);
                disp('*******************************************************************************************');
                disp('LINHAS ORDENADAS, SEGUNDO O CRITÉRIO DA MATRIZ L, DA MAIS CRÍTICA PARA DE MENOR CRITICIDADE')
                disp('*******************************************************************************************');
                disp('Criticidade  |I|      |I N-1|')
                disp('***********************************************');
                disp(comparacao2)
                disp('****************************************************************************');
                disp('PERDAS DO SISTEMA COMPLETO E PERDAS SISTEMA COM CONTINGÊNCIA, APÓS O REFORÇO')
                disp(perdas)
                operador=0;
            end
            if variavel_ex==0 && variavel_ex2==0
                disp('Escolha um conjunto de dados');
            end
        case 7
            i=2;
    end
end