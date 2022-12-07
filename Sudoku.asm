TITLE ENTRADA E E SAIDA DE MATRIZ, INVERSAO DE LINHAS POR COLUNAS
.MODEL SMALL
.STACK 100h
.DATA
menu db '[1]FACIL',10,'[2]MEDIO',10,'[3]DIFICIL',10,'Qual a dificuldade voce deseja escolher->$'
FACIL3 DB '=========================',10,'DIFICULDADE FACIL',10,'=========================$'
MEDIO3 DB '=========================',10,'DIFICULDADE MEDIO',10,'=========================$'
DIFICIL3 DB '=========================',10,'DIFICULDADE DIFICIL',10,'=========================$'
ERRO1 DB 10,'ERRO NA LEITURA POR FAVOR DIGITE NOVAMENTE:$'
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
         MOV AH,0
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
       JMP FIM
MEDIO2:
    CMP AL,'2'
    JNE DIFICIL2
    pulalinha
    CALL MEDIO
    CALL MATRIZ_OUT
    JMP FIM
DIFICIL2:
    CMP AL,'3'
    JNE ERRO
    pulalinha
    CALL DIFICIL
    CALL MATRIZ_OUT
    JMP FIM
ERRO:
    MOV AH,09
    LEA DX,ERRO1
    INT 21H
    JMP INICIO
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
    MEDIO ENDP

    DIFICIL PROC
         MOV AH,09h
        LEA DX,DIFICIL3
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
    DIFICIL ENDP
    end main