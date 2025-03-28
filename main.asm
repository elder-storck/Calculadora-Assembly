segment code

;org 100h
..start:
    MOV     AX,data			;Inicializa os registradores
	MOV 	DS,AX
    MOV 	AX,stack
	MOV 	SS,AX
    MOV 	SP,stacktop

;inicio do programa

loop_main:

    mov ah,9
    mov dx,mensagem
    int 21h

    ;Leitura da entrada do usuário
    mov dx, buffer ; Endereço do offset onde a entrada será armazenada
    mov ah, 0Ah ; Função 0Ah para leitura do teclado
    int 21h ; Interrupção para leitura dos dados

    call Print_input
    
    mov ah,byte[buffer+2]
    cmp ah,'s'
    je sair

    mov ah, [buffer+2]
    cmp ah, '-'
    je sair

    
    



    ;mov ah,9


    ;je Print_input

    ;jmp number1_pos

    ;number1 positivo
    ;mov ah,byte

    



    jmp loop_main

sair:
    mov ah, 4Ch
    int 21h

Print_input:
    ; Adiciona terminador '$' após a entrada
    mov bx, buffer+1    ; Offset do tamanho real
    mov bl, [bx]        ; BL = número de caracteres lidos
    mov bh, 0
    mov [buffer+2+bx], byte '$' ; Coloca '$' após a string

    ; Mostra o que foi lido
    mov ah, 9
    mov dx, buffer+2    ; Offset do início da string
    int 21h
ret

number1_neg:
    mov al, byte[buffer + 6]
    cmp al,'+'
    je Operacao

    cmp al,'-'
    je Operacao

    cmp al,'*'
    je Operacao

    cmp al,'/'
    je Operacao

; nn_op_
    mov al,byte[buffer + 8] ; operação
    jmp Operacao

    n_op:
    mov al,byte[buffer + 6] ; operação
    jmp Operacao

number1_pos:
    mov ah, byte[buffer + 4]
    cmp ah,'+'
    je p_op
    cmp ah,'-'
    je p_op
    cmp ah,'*'
    je p_op
    cmp ah,'/'
    je p_op

; pp_op_
    mov al,byte[buffer + 6] ; operação
    jmp Operacao
p_op:
    mov al,byte[buffer + 4] ; operação
    jmp Operacao
    
    
Operacao:
    ;operaçao já está em l
    cmp al,'+'
    je Somar
    cmp al,'-'
    je Subtrair
    cmp al,'*'
    je Multiplicar
    cmp al,'/'
    je Dividir

    jmp loop_main


Somar:
    mov ah,9
    mov dx,opSoma
    int 21h
    jmp loop_main

Subtrair:
    mov ah,9
    mov dx,opSub
    int 21h
    jmp loop_main

Multiplicar:
    mov ah,9
    mov dx,opMult
    int 21h
    jmp loop_main

Dividir:
    mov ah,9
    mov dx,opDiv
    int 21h
    jmp loop_main

    
    

;    mov ah,9
;    mov dx,resultado
;    int 21h













segment data 
    CR equ 0dh
    LF equ 0ah
    mensagem db 'entre com operacao no formato (-99 a 99)( op )(-99 a 99)',CR,LF,'$'

    ;buffer db '-00+-00'   ; Reserva 7 bytes
    buffer db 10, 0       ; Buffer para entrada (tamanho máximo 10)
           times 10 db 0  ; Espaço para os dados
    resultado db '-00+-00',CR,LF,'$'

    newline db CR,LF,'$'

    opSoma db 'op soma',CR,LF,'$'
    opSub db 'op sub',CR,LF,'$'
    opMult db 'op mult',CR,LF,'$'
    opDiv db  'op div',CR,LF,'$'

segment stack stack
    resb 256
stacktop:
