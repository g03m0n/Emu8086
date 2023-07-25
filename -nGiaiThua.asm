inchuoi MACRO chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm
dseg segment
    muoi dw 10
    tb1 db 'Nhap so khong am be hon hoac bang 8: $'
    tb2 db 10,13, 'Ket qua: $' 
dseg ends
cseg segment
    assume cs: cseg, ds: cseg
start:
    mov ax,dseg
    mov ds,ax 
      
    inchuoi tb1
    
    mov ah, 01h
    int 21h
    
    sub al, 30h
    xor cx, cx
    mov cl, al
    
    inchuoi tb2
    
    mov ax, 1
    mov bx, 1
    
Giaithua:
    mul bx
    inc bx
    cmp bx, cx
    jle Giaithua
    
    call dec_out
    
    mov ah, 4Ch
    int 21h

dec_out proc
    xor cx, cx
    mov bx, 10
    
chia10:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz chia10
    
inra:
    mov ah, 02h
    pop dx
    add dl, 30h
    int 21h
    loop inra
    
    ret
dec_out endp
cseg ends
end start