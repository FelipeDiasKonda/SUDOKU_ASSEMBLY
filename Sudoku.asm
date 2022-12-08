TITLE ENTRADA E E SAIDA DE MATRIZ, INVERSAO DE LINHAS POR COLUNAS
.MODEL SMALL
.STACK 100h
.DATA
menu db '[1]FACIL',10,'[2]MEDIO',10,'[3]DIFICIL',10,'Qual a dificuldade voce deseja escolher->$'
FACIL3 DB '=========================',10,'DIFICULDADE FACIL',10,'=========================$'
MEDIO3 DB '=========================',10,'DIFICULDADE MEDIO',10,'=========================$'
DIFICIL3 DB '=========================',10,'DIFICULDADE DIFICIL',10,'=========================$'
ERRO1 DB 10,'ERRO NA LEITURA POR FAVOR DIGITE NOVAMENTE:$'
MSGLER1 DB 10,'ANDE PARA A CASA DESEJADA COM AS SETAS DO TECLADO$'
MSGLER DB 10,'VOCE ESTA NA CASA->$'
LERNUMERO DB 10,'AGORA BASTA DIGITAR O NUMERO QUE DESEJA INSERIR->$'
ADICIONARNUM DB 'DESEJA ADICIONAR OUTRO NUMERO(S/N)->$'
NUMEROERRADO DB 10,'NUMERO ERRADO$'
PERDEU DB 10,'VOCE PERDEU$'
PARABENS DB 10,'PARABENS VOCE GANHOU O SUDOKU$'
JOGARDENOVO DB 10,'VOCE GOSTARIA DE JOGAR DE NOVO(S/N)?$'
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
    pulalinha macro
    mov ah,02h
    mov dl,10
    int 21h
    endm
    PRINT MACRO MENSAGEM
        LEA DX,MENSAGEM
        MOV AH,09h         
	    INT 21h 
    ENDM

    MAIN PROC
    
MENU1:  MOV AH,0
        MOV AL,06h  
        INT 10H
        MOV AH,0BH
        MOV BH,00H       
        MOV BL,0          ;cor de fundo
        INT 10H
        MOV AH,0Bh   
        MOV BH,1           ;FUncao para trocar a cor das letras
        MOV BL,0            ;seleciona a paleta 
        INT 10H
        MOV AX,@DATA;
        MOV DS,AX   ; Inicia o segmento de dados     
          MOV AH,09
        LEA DX, menu
        INT 21H
INICIO:
        MOV AH,01
        INT 21H
        OR AL,30H
FACIL2:
        CMP AL,'1'
        JNE MEDIO2
        pulalinha
        CALL FACIL
        CALL MATRIZ_OUT
        CALL LEITURA
        CALL CORRIGE_MAT
        MOV AH,09
        LEA DX,JOGARDENOVO
        INT 21H
        MOV AH,01
        INT 21H
        CMP AL,'s'
        JE MENU1
        JMP FIM
MEDIO2:
    CMP AL,'2'
    JNE DIFICIL2
    pulalinha
    CALL MEDIO
    CALL MATRIZ_OUT
    CALL LEITURA
    CALL CORRIGE_MAT
    MOV AH,09
    LEA DX,JOGARDENOVO
    INT 21H
    MOV AH,01
    INT 21H
    CMP AL,'s'
    JE TESTE
    JMP FIM
    JMP FIM
DIFICIL2:
    CMP AL,'3'
    JNE ERRO
    pulalinha
    CALL DIFICIL
    CALL MATRIZ_OUT
    CALL LEITURA
    CALL CORRIGE_MAT
    MOV AH,09
    LEA DX,JOGARDENOVO
    INT 21H
    MOV AH,01
    INT 21H
    CMP AL,'s'
    JE TESTE
    JMP FIM
    JMP FIM
ERRO:
    MOV AH,09
    LEA DX,ERRO1
    INT 21H
    JMP INICIO
TESTE:
JMP MENU1
    FIM:
        MOV AH,4CH
        INT 21H
    MAIN ENDP

    MATRIZ_OUT PROC ; Proc para leitura e impressao de matriz
        XOR BX,BX
        XOR SI,SI
        
        PRINT MOLDURA

        MOV CL, LIN             ; Usado como contador de linhas    

        OUT1:                           ;   
            MOV CH, COL                 ; Usado como contador de colunas  
            OUT2:                       ; 
                PRINT LINHA
                MOV AH, 02h  
                MOV DL, MATRIZ[BX][SI]  ; Copia a informacao da matriz para DL(entrada padrao para função 02h)  
                OR DL, 30h              ; Converte para caracter
                INT 21h                 ;   
                MOV DL, 20H
                INT 21H             
                INC SI                  ; Atualiza o endereço da matriz, deslocando para a proxima coluna  
                DEC CH                  ;   
            JNZ OUT2                ; LOOP1
            MOV DL, 0BAH
            INT 21H
            MOV DL, 10              ; 
            INT 21h                 ; LINE FEED
            PRINT LINHA2  
            ADD BX, LIN             ; Desloca uma linha na matriz  
            XOR SI,SI               ; Reseta as colunas
            DEC CL                  ;   
        JNZ OUT1                ; LOOP2 (nao utilizado LOOP, pois estamos utilizando CX para outro "loop" temos um loop1 dentro do outro loop2)
        RET
    MATRIZ_OUT ENDP

    FACIL PROC
        MOV AH,09h
        LEA DX,FACIL3
        INT 21H
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
        LEA DX,MEDIO3
        INT 21H
        pulalinha
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
        LEA DX,DIFICIL3
        INT 21H
        pulalinha
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