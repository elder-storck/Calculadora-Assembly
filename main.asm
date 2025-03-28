segment code

;org 100h
..start:
    MOV     AX,data			;Inicializa os registradores
	MOV 	DS,AX
    MOV 	AX,stack
	MOV 	SS,AX
    MOV 	SP,stacktop

;inicio do programa
    mov ah,9
    mov dx,mensagem
    int 21h


; Terminar o programa
    mov ah,4ch
    int 21h

segment data 
    CR equ 0dh
    LF equ 0ah
    mensagem db 'eu tenteiiiiiii',CR,LF,'$'

segment stack stack
    resb 256
stacktop: