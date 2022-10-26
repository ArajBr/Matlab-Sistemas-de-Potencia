clear all;
clc;

variavel_ex=0;
variavel_ex2=0;
while i < 1
    x=menu('Representação de Redes Elétricas',...
        'LEITURA DOS DADOS DE ENTRADA',...
        'PRÉ-PROCESSAMENTO E ANÁLISE',....
        'GRAFOS',...
        'OBTENÇÃO DE YBARRA',...
        'OBTENÇÃO DE ZBARRA',...
        'FATORAÇÃO LU',...
        'SAIR');
    
    switch x
        case 1
            y=menu('Leitura dos dados a serem utilizados','Dados 1','Dados 2');
            switch y
                case 1
                    sep = [0 1 1 0.8; 1 2 0 0.25; 2 3 0 0.4;0 1 0 1.25; 0 3 0 1.25; 3 4 0 0.2; 2 4 0 0.125]; %matirz slide
                    variavel_ex=1;
                    n_matriz=1;
                    disp('*************MATRIZ SELECIONADA*************');
                    disp(sep)
                    disp('********************************************');
                case 2
                    sep = [0 1 0 0.5;1 2 0 0.3;1 4 0 1;2 3 0 0.1;3 4 0 1;0 3 0 0.2]
                    variavel_ex=1;
                    n_matriz=2;
            end
        case 2
            clc
            if variavel_ex==1
                disp('Dados do SEP disponveis na variável trataSep.');
                disp('********************************************');
                [sep,linha,Adj,grafo]=trataSep(sep);
                disp('********************************************');
                disp('O número de árvores possíveis é de:');
                disp(Adj(1,1));
                n_nos=max(max(grafo));
                disp('O número de elementos é de:');
                disp(linha);
                disp('O número de nós é de:');
                disp(n_nos);
                disp('O número de laços básicos é de:');
                n_lacos=linha-n_nos+1;
                disp(n_lacos);
                disp('*************MATRIZ SELECIONADA*************');
                disp(sep)
                disp('********************************************');
                variavel_ex2=1;
            end
            if  variavel_ex==1;
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
        case 3
            clc
            if variavel_ex==1 && variavel_ex2==1
                b = desenhaGrafo(grafo);
            end
            if variavel_ex==1 && variavel_ex2==0
                disp('pré-processe o conjunto de dados');
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
        case 4
            clc
            if variavel_ex==1 && variavel_ex2==1
                ybarra = criaYbarra(sep);
                disp('*************DADOS DO SISTEMA*************');
                disp('Qtd barras:');
                disp(n_nos);
                disp('Qtd linhas:');
                disp(linha);
                disp('Matriz Utilizada:');
                disp(n_matriz);
                disp('*************OBTENÇÃO DE YBARRA*************');
                disp(ybarra)
                disp('********************************************');
            end
            if variavel_ex==1 && variavel_ex2==0
                disp('pré-processe o conjunto de dados');
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
            
        case 5
            clc
            if variavel_ex==1 && variavel_ex2==1
                [zbarra] = criaZbarra(sep);
                disp('*************DADOS DO SISTEMA*************');
                disp('Qtd barras:');
                disp(n_nos);
                disp('Qtd linhas:');
                disp(linha);
                disp('Matriz Utilizada:');
                disp(n_matriz);
                disp('*************OBTENÇÃO DE ZBARRA*************');
                disp(zbarra)
                disp('********************************************');
            end
            if variavel_ex==1 && variavel_ex2==0
                disp('pré-processe o conjunto de dados');
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
            
        case 6
            clc
            if variavel_ex==1 && variavel_ex2==1
                zbarra = criaZbarra(sep);
                [L,U]=DecomLDU(zbarra);
                disp('*************DADOS DO SISTEMA*************');
                disp('Qtd barras:');
                disp(n_nos);
                disp('Qtd linhas:');
                disp(linha);
                disp('Matriz Utilizada:');
                disp(n_matriz);
                disp('*************DECOMPOSIÇÃO LU*************');
                disp('*****************MATRIZ L****************');
                disp(L);
                disp('*****************MATRIZ U****************');
                disp(U);
                disp('********************************************');
            end
            if variavel_ex==1 && variavel_ex2==0
                disp('pré-processe o conjunto de dados');
            end
            if variavel_ex==0
                disp('Escolha um conjunto de dados');
            end
        case 7
            i=2;
    end
    
end