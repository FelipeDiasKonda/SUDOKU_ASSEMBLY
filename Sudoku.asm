TITLE Eduardo de Faria Rios Perucello - 22009978
TITLE Felipe Dias Konda - 22008026
.MODEL SMALL
.STACK 100h
.DATA
menu db 10,10,'              [1]FACIL','              [2]MEDIO','              [3]DIFICIL',10,10,'                    Qual a dificuldade voce deseja escolher->$'
MENU2 DB 10,'                 BEM VINDO AO PROJETO DO SUDOKU EM ASSEMBLY X86',10,'  ESSE PROJETO FOI DESENVOLVIDO PELOS ALUNOS FELIPE KONDA E EDUARDO PERUCELLO$'
MENU3 DB 10,10,'===============================================================================',10,'                             SELECIONE A DIFICULDADE',10,'===============================================================================$'
FACIL3 DB '===============================================================================',10,'                             DIFICULDADE FACIL',10,'===============================================================================$'
MEDIO3 DB '===============================================================================',10,'                             DIFICULDADE MEDIO  ',10,'===============================================================================$'
DIFICIL3 DB '===============================================================================',10,'                             DIFICULDADE DIFICIL  ',10,'===============================================================================$'
ERRO1 DB 10,'ERRO NA LEITURA POR FAVOR DIGITE NOVAMENTE:$'
MSGLER1 DB 10,'ANDE PARA A CASA DESEJADA COM AS SETAS DO TECLADO$'
MSGLER DB 10,'VOCE ESTA NA CASA->$'
LERNUMERO DB 10,'AGORA BASTA DIGITAR O NUMERO QUE DESEJA INSERIR->$'
ADICIONARNUM DB 'DESEJA ADICIONAR OUTRO NUMERO(S/N)->$'
NUMEROERRADO DB 10,'NUMERO ERRADO$'
PERDEU DB 10,'===============================================================================',10,'                                 VOCE PERDEU',10,'===============================================================================$'
PARABENS DB 10,'===============================================================================',10,'                          PARABENS VOCE GANHOU O SUDOKU',10,'===============================================================================$'
JOGARDENOVO DB 10,'  VOCE GOSTARIA DE JOGAR DE NOVO(S/N)?$'
FACILGABARITO DB 4, 6, 5, 2, 7, 9, 3, 1, 8
              DB 7, 1, 8, 5, 6, 3, 4, 2, 9  
              DB 3, 9, 2, 4, 1, 8, 5, 6, 7
              DB 9, 2, 4, 6, 5, 1, 7, 8, 3
              DB 1, 3, 6, 7, 8, 4, 2, 9, 5
              DB 5, 8, 7, 9, 3, 2, 6, 4, 1
              DB 6, 4, 3, 1, 9, 7, 8, 5, 2
              DB 2, 7, 1, 8, 4, 5, 9, 3, 6
              DB 8, 5, 9, 3, 2, 6, 1, 7, 4

MEDIOGABARITO DB 9, 4, 8, 3, 5, 1, 6, 7, 2
              DB 2, 7, 5, 4, 6, 9, 8, 3, 1  
              DB 6, 3, 1, 2, 8, 7, 5, 4, 9
              DB 3, 8, 7, 6, 9, 2, 4, 1, 5
              DB 4, 9, 2, 8, 1, 5, 7, 6, 3
              DB 5, 1, 6, 7, 3, 4, 9, 2, 8
              DB 1, 6, 9, 5, 7, 3, 2, 8, 4
              DB 8, 2, 3, 9, 4, 6, 1, 5, 7
              DB 7, 5, 4, 1, 2, 8, 3, 9, 6

DIFICILGABARITO DB 6, 5, 4, 3, 7, 2, 9, 1, 8
                DB 2, 7, 8, 1, 5, 9, 6, 4, 3  
                DB 3, 9, 1, 8, 6, 4, 2, 5, 7
                DB 5, 3, 9, 2, 8, 7, 4, 6, 1
                DB 7, 8, 6, 9, 4, 1, 5, 3, 2
                DB 1, 4, 2, 6, 3, 5, 7, 8, 9
                DB 8, 2, 5, 4, 9, 3, 1, 7, 6
                DB 4, 1, 3, 7, 2, 6, 8, 9, 5
                DB 9, 6, 7, 5, 1, 8, 3, 2, 4
LIN  EQU  9 
COL  EQU  9
    MATRIZ DB LIN DUP(COL DUP(?))
MOLDURA DB 0C9H, 8 DUP (3 DUP (0CDH), 0CBH), 3 DUP (0CDH), 0BBH , 10,'$'
LINHA  DB 0BAH, 20H, '$'
LINHA2 DB 0CCH, 8 DUP (3 DUP (0CDH), 0CEH), 3 DUP (0CDH), 0B9H , 10,'$'
 
.CODE
    pulalinha macro         ;macro de pular linha
    mov ah,02h
    mov dl,10
    int 21h
    endm
    PRINT MACRO MENSAGEM    ;macro de printar mensagem 
        LEA DX,MENSAGEM
        MOV AH,09h         
	    INT 21h 
    ENDM

    MAIN PROC               ;inicio da main
    
MENU1:  MOV AH,0            ;modo de resolução
        MOV AL,06h  
        INT 10H
        MOV AH,0BH          ;função para mudar a cor de fundo
        MOV BH,00H       
        MOV BL,0            ;cor de fundo
        INT 10H
        MOV AH,0Bh   
        MOV BH,1            ;FUncao para trocar a cor das letras
        MOV BL,0            ;seleciona a paleta 
        INT 10H
        MOV AX,@DATA;
        MOV DS,AX           ; Inicia o segmento de dados     
        MOV AH,09
        LEA DX,MENU2        ;aqui oomeçam os prints do menu
        INT 21H
        LEA DX,MENU3
        INT 21H
        LEA DX, menu        ;print de selecionar a dificuldade
        INT 21H
INICIO:
        MOV AH,01           ;le a dificuldade escolhida e transforma em numero para efetuar as comparações
        INT 21H
        OR AL,30H
FACIL2:
        CMP AL,'1'          ;verifica se a dificuldade escolhida foi a facil
        JNE MEDIO2          ;caso nao for a facil ele da um jump para ver se eh a medio
        pulalinha           ;macro de pular linha
        CALL FACIL          ;chama a funcao que preenche a MATRIZ com os numeros do facil
        CALL MATRIZ_OUT     ;chama a função que print a matriz
        CALL LEITURA        ;chama a função que faz a leitura de tudo que o usuario deseja inserir na matriz
        CALL CORRIGE_MAT    ;chama a função que verifica se o usuario acertou o sudoku
        MOV AH,09
        LEA DX,JOGARDENOVO  ;verifica se o usuario deseja jogar de novo
        INT 21H
        MOV AH,01
        INT 21H
        CMP AL,'s'
        JE MENU1            ;caso o usuario deseje jogar de novo ele salta para o menu
        JMP FIM             ;caso ele nao queira ele vai para o fim do programa
MEDIO2:
    CMP AL,'2'              ;verifica se a dificuldade escolhida foi o medio
    JNE DIFICIL2            ;caso nao tenha sido ele vai verificar se eh a dificil
    pulalinha               ;macro de pular linha
    CALL MEDIO              ;chama a função que preenche a matriz com os numeros do medio
    CALL MATRIZ_OUT         ;printa a matriz
    CALL LEITURA            ;chama a função que faz a leitura de tudo que o usuario deseja inserir na matriz
    CALL CORRIGE_MAT        ;chama a função que verifica se o usuario acertou o sudoku
    MOV AH,09
    LEA DX,JOGARDENOVO      ;verifica se o usuario deseja jogar de novo
    INT 21H
    MOV AH,01
    INT 21H
    CMP AL,'s'              ;caso ele queira ele vai pro teste e esse teste ele vai pro inicio
    JE TESTE                ;coloquei esse je teste pois o comeco estava muito longe e o jump nao funcionava
    JMP FIM                 ;caso nao queira jogar dnovo ele da um jump pro fim
DIFICIL2:
    CMP AL,'3'              ;verifica se a dificuldade escolhida foi a dificil
    JNE ERRO                ;caso nao seja ele vai pra mensagem de erro, e pede a entrada denovo
    pulalinha               ;macro de pular linha
    CALL DIFICIL            ;preenche a matriz com os numeros da dificuldade dificil
    CALL MATRIZ_OUT         ;printa a matriz
    CALL LEITURA            ;chama a função que faz a leitura de tudo que o usuario deseja inserir na matriz
    CALL CORRIGE_MAT        ;chama a função que verifica se o usuario acertou o sudoku
    MOV AH,09
    LEA DX,JOGARDENOVO      ;mensagem de jogar denovo
    INT 21H
    MOV AH,01
    INT 21H
    CMP AL,'s'              ;caso ele queira ele vai pro teste e esse teste ele vai pro inicio
    JE TESTE                ;coloquei esse je teste pois o comeco estava muito longe e o jump nao funcionava
    JMP FIM                 ;caso nao queira jogar dnovo ele da um jump pro fim
ERRO:
    MOV AH,09
    LEA DX,ERRO1
    INT 21H                 ;mensagem de erro 
    JMP INICIO              ;jmp para ler denovo a dificuldade
TESTE:
JMP MENU1
    FIM:
        MOV AH,4CH          ;fim do programa
        INT 21H
    MAIN ENDP

    MATRIZ_OUT PROC         ;procedimento para imprimir a matriz
        XOR BX,BX           ;zera os registradores que serao usados para andar na matriz
        XOR SI,SI
        
        PRINT MOLDURA

        MOV CL, LIN         ;Usado como contador de linhas    

        OUT1:                             
            MOV CH, COL     ;contador de colunas  
            OUT2:                        
                PRINT LINHA
                MOV AH, 02h  
                MOV DL, MATRIZ[BX][SI]  ;Copia a informacao da matriz para DL  
                OR DL, 30h              ;Converte para caracter
                INT 21h                    
                MOV DL, 20H
                INT 21H             
                INC SI                  ;Atualiza o endereço da matriz, deslocando para a proxima coluna  
                DEC CH                     
            JNZ OUT2                 
            MOV DL, 0BAH
            INT 21H
            MOV DL, 10               
            INT 21h               
            PRINT LINHA2  
            ADD BX, LIN                 ;Desloca uma linha na matriz  
            XOR SI,SI                   ;Reseta as colunas
            DEC CL                     
        JNZ OUT1                
        RET
    MATRIZ_OUT ENDP

    FACIL PROC                          ;procedimento usado para preencher a matriz com os numeros pre colocados
        MOV AH,09h
        LEA DX,FACIL3                   ;neste procedimento foram usados os registradores BX e SI para andar na matriz
        INT 21H                         ;onde o BX eh para as linhas e o SI para andar entre as colunas
        pulalinha
        XOR BX,BX
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],6
            ADD SI,3
            MOV MATRIZ [BX][SI],7
            ADD SI, 3
            MOV MATRIZ [BX][SI],1
        ADD BX, LIN
        XOR SI,SI
            ADD SI, 2
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],5
            INC SI
            MOV MATRIZ [BX][SI],6
            ADD SI,4
            MOV MATRIZ [BX][SI],9
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],3
            ADD SI, 4
            MOV MATRIZ [BX][SI],1
            ADD SI,2
            MOV MATRIZ [BX][SI],5
            ADD SI,2
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI
        ADD SI,4
            MOV MATRIZ [BX][SI],5
            INC SI
            MOV MATRIZ [BX][SI],1
        ADD BX, LIN
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],7
        ADD BX,LIN
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],7
            ADD SI,2
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],2
            ADD SI,2
            MOV MATRIZ [BX][SI],4
            INC SI
            MOV MATRIZ [BX][SI],1
        ADD BX, LIN
        XOR SI,SI    
            
            MOV MATRIZ [BX][SI],6
            ADD SI,4
            MOV MATRIZ [BX][SI],9
            ADD SI, 3
            MOV MATRIZ [BX][SI],5
            INC SI
            MOV MATRIZ [BX][SI],2
        ADD BX, LIN
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],7
            ADD SI,2
            MOV MATRIZ [BX][SI],8
            ADD SI, 2
            MOV MATRIZ [BX][SI],5
        ADD BX, LIN
        XOR SI,SI
    
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI,3
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],1
            ADD SI,2
            MOV MATRIZ [BX][SI],4
        RET  
    FACIL ENDP

    MEDIO PROC  
        MOV AH,09h
        LEA DX,MEDIO3                   ;procedimento usado para preencher a matriz com os numeros pre colocados
        INT 21H                         ;neste procedimento foram usados os registradores BX e SI para andar na matriz
        pulalinha                       ;onde o BX eh para as linhas e o SI para andar entre as colunas
        XOR BX,BX
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],4
            ADD SI,4
            MOV MATRIZ [BX][SI],1
            INC SI 
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],7
            INC SI
            MOV MATRIZ [BX][SI],2
        ADD BX, LIN
        XOR SI,SI
            ADD SI, 3
            MOV MATRIZ [BX][SI],4
            INC SI
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],9
            INC SI
            MOV MATRIZ [BX][SI],8
              INC SI
            MOV MATRIZ [BX][SI],3
              INC SI
            MOV MATRIZ [BX][SI],1
        ADD BX, LIN
        XOR SI,SI
        INC SI
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],2
            ADD SI,2
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI
        ADD SI,8
            MOV MATRIZ [BX][SI],5
        ADD BX, LIN
        XOR SI,SI
            ADD SI,3
            MOV MATRIZ [BX][SI],8
            ADD SI,2
            MOV MATRIZ [BX][SI],5
            ADD SI,3
            MOV MATRIZ [BX][SI],3
        ADD BX,LIN
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],6
        ADD BX, LIN
        XOR SI,SI    
            INC SI
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],9
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI,2
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],2
            ADD SI,2
            MOV MATRIZ [BX][SI],4
        ADD BX, LIN
        XOR SI,SI
            ADD SI,3
            MOV MATRIZ [BX][SI],9
            INC SI
            MOV MATRIZ [BX][SI],4
            ADD SI,2
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],5
            INC SI
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],7
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI,2
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],3
        RET   
    MEDIO ENDP

    DIFICIL PROC
         MOV AH,09h
        LEA DX,DIFICIL3                 ;procedimento usado para preencher a matriz com os numeros pre colocados
        INT 21H                         ;neste procedimento foram usados os registradores BX e SI para andar na matriz
        pulalinha                       ;onde o BX eh para as linhas e o SI para andar entre as colunas
        XOR BX,BX
        XOR SI,SI
            ADD SI, 2
            MOV MATRIZ [BX][SI],4
            ADD SI,2
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],2
            ADD SI,7
            MOV MATRIZ [BX][SI],3
        ADD BX, LIN
        XOR SI,SI
        INC SI
            MOV MATRIZ [BX][SI],9
            ADD SI,2
            MOV MATRIZ [BX][SI],8
            ADD SI,2
            MOV MATRIZ[BX][SI],4
            ADD SI,2
            MOV MATRIZ[BX][SI],5
        ADD BX, LIN
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],9
            ADD SI,3
            MOV MATRIZ [BX][SI],4
        ADD BX,LIN
        XOR SI,SI
            ADD SI,5
            MOV MATRIZ [BX][SI],1
        ADD BX, LIN
        XOR SI,SI    
            ADD SI,2
            MOV MATRIZ [BX][SI],4
            ADD SI,2
            MOV MATRIZ [BX][SI],6
            ADD SI, 2
            MOV MATRIZ [BX][SI],5
            ADD SI,2
            MOV MATRIZ [BX][SI],8
        ADD BX, LIN
        XOR SI,SI
            ADD SI,4
            MOV MATRIZ [BX][SI],9
            ADD SI,3
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],7
            ADD SI,2
            MOV MATRIZ [BX][SI],6
            ADD SI,3
            MOV MATRIZ [BX][SI],5
        ADD BX, LIN
        XOR SI,SI
        INC SI
        MOV MATRIZ [BX][SI],6
        ADD SI,3
        MOV MATRIZ [BX][SI],1
        RET  
    DIFICIL ENDP
    LEITURA PROC
    XOR BX,BX
    XOR CX,CX
    INC CL
    INC CH
 COMECO:
        MOV AH,09
        LEA DX,MSGLER1
        INT 21H
        LEA DX,MSGLER
        INT 21H
        XOR DX,DX
        MOV AH,02
        MOV DL,CL
        OR DL,30H
        INT 21H
        MOV AH,02
        MOV DL,'x'
        INT 21H
        MOV AH,02
        MOV DL,CH
        OR DL,30H
        INT 21H      
        MOV AH,00H
        INT 16H
        CMP AH,72
        JNE COMPBAIXO
        SUB BX,LIN
        SUB CL,1
        JMP comeco
    COMPBAIXO:
        CMP AH,80
        JNE COMPDIREITA
        ADD BX,LIN
        ADD CL,1
        JMP COMECO
    COMPDIREITA:
        CMP AH,4DH
        JNE COMPESQUERDA
        INC SI
        INC CH
        JMP COMECO
    COMPESQUERDA:
        CMP AH,4BH
        JNE ENTER1
        DEC SI
        DEC CH
        JMP COMECO
    ENTER1:
        CMP AX,1C0DH
        JNE COMECO
        MOV AH,09
        LEA DX,LERNUMERO
        INT 21H
        MOV AH,01
        INT 21H
    IGUAL:
        MOV MATRIZ [BX][SI],AL
        pulalinha
        MOV AH,09
        LEA DX,ADICIONARNUM
        INT 21h
        MOV AH,01
        INT 21H
        CMP AL,'n'
        JE EXIT
        MOV AH,06
        MOV AL,00
        INT 10H
        pulalinha
        CALL MATRIZ_OUT
        INC CL
        INC CH
        XOR BX,BX
        XOR SI,SI
        JMP COMECO
EXIT:
    RET
    LEITURA ENDP
    CORRIGE_MAT PROC
        XOR BX,BX
        XOR SI,SI
        XOR CX,CX
        MOV AL,MATRIZ[BX][SI]
        MOV CX,9
    CORRIGE:
        INC SI
        ADD AL,MATRIZ[BX][SI]
        LOOP CORRIGE
        CMP AL,45
        JNE ERRADO
        ADD BX,LIN
        INC DX
        CMP DX,9
        JE IGUAL4
    ERRADO:
        MOV AH,09
        LEA DX,PERDEU
        INT 21H
        JMP EXIT2
    IGUAL4:
    MOV AH,09
    LEA DX,PARABENS
    INT 21H
    EXIT2:
    RET
    CORRIGE_MAT ENDP
    end main