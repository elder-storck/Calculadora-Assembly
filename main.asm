segment code
    ..start:
    mov ax, data
    mov ds, ax
    mov ax, stack 
    mov ss, ax
    mov sp, stacktop
    
main:
    mov dx, offset 
    mov ah, 0Ah 
    int 21h 
    
    mov dx, nova_linha
    mov ah, 09h
    int 21h
    
    mov al, byte[offset+2] 
    
    cmp al, 's' 
    je exit 

    xor ax, ax
    xor bx, bx
    
    call processar_expressao
    
    call print
    jmp main

exit:
    mov ah, 4Ch
    int 21h

processar_expressao:
    push bx
    push cx
    push dx
    push si
    push di
    
    mov si, offset+2
    call encontrar_operador
    
    mov si, offset+2
    mov cx, di
    sub cx, si
    call processar_numero
    mov bx, ax
    
    mov si, di
    inc si
    call processar_numero
    mov cx, ax
    
    mov dl, [di]
    call calculate
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret

encontrar_operador:
    mov di, si
loop_operador:
    mov dl, [di]
    cmp dl, '+'
    je operador_encontrado
    cmp dl, '-'
    je verificar_negativo
    cmp dl, '*'
    je operador_encontrado
    cmp dl, '/'
    je operador_encontrado
    inc di
    jmp loop_operador

verificar_negativo:
    cmp di, offset+2
    je nao_e_operador
    mov al, [di-1]
    cmp al, '+'
    je nao_e_operador
    cmp al, '-'
    je nao_e_operador
    cmp al, '*'
    je nao_e_operador
    cmp al, '/'
    je nao_e_operador
    jmp operador_encontrado

nao_e_operador:
    inc di
    jmp loop_operador
    
operador_encontrado:
    ret

processar_numero:
    push bx
    push cx
    push dx
    push si
    
    xor ax, ax
    xor dh, dh
    
    mov bl, byte [si]
    cmp bl, '-'
    jne nao_negativo
    mov dh, 1
    inc si
    
nao_negativo:
    xor ax, ax
    mov bl, byte [si]
    cmp bl, '0'
    jl fim_digitos
    cmp bl, '9'
    jg fim_digitos
    
    sub bl, '0'
    movzx ax, bl
    inc si
    
    mov bl, byte [si]
    cmp bl, '0'
    jl fim_digitos
    cmp bl, '9'
    jg fim_digitos
    
    imul ax, 10  
    sub bl, '0'
    movzx bx, bl
    add ax, bx   
    
fim_digitos:
    cmp dh, 1
    jne fim_processar
    neg ax
    
fim_processar:
    pop si
    pop dx
    pop cx
    pop bx
    ret

calculate:
    cmp dl, '+' 
    je sum 
    cmp dl, '-' 
    je subtr 
    cmp dl, '*' 
    je mult 
    cmp dl, '/' 
    je divs
    jmp exit 

sum: 
    mov ax, bx  
    add ax, cx  
    mov word [resultado], ax 
    ret

subtr:
    mov ax, bx  
    sub ax, cx  
    mov word [resultado], ax 
    ret

mult:
    mov ax, bx  
    imul cx     
    mov word [resultado], ax 
    ret

divs:
    cmp cx, 0   
    mov ax, bx  
    cwd         
    idiv cx     
    mov word [resultado], ax 
    ret

print:
    mov ax, word [resultado] 
    call bin2ascii 
    mov dx, saida 
    mov ah, 09h 
    int 21h 
    ret

bin2ascii:
    push ax 
    push bx
    push cx
    push dx
    push si
    
    mov cx, 0 
    test ax, ax
    jns positivo
    neg ax 
    mov cx, 1 

positivo:
    mov si, 4 
    mov bx, 10 

conversao_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov byte[saida+si], dl
    dec si
    test ax, ax
    jnz conversao_loop
    
preenche_zeros:
    cmp si, 0
    jl adiciona_sinal 
    mov byte[saida+si], '0'
    dec si
    jmp preenche_zeros
    
adiciona_sinal:
    test cx, cx
    jz fim_bin2ascii
    mov byte[saida], '-'

fim_bin2ascii:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax 
    ret

segment data
    CR equ 0Dh 
    LF equ 0Ah 
    nova_linha db CR, LF, '$' 
    offset db '0000000000' 
    saida db '00000',13,10,'$'
    resultado dw 0 

segment stack stack
    resb 256
stacktop:
