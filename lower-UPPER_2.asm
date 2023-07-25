inchuoi MACRO chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm
.model small
.stack 100h
.data
    input db 50 dup (0)
    len equ $-input
    upper db 50 dup (0)
    lower db 50 dup (0)
    
    chuoi db 50 dup(?)
    msg1 db "Nhap chuoi bat ky: $"
    msg2 db 10, 13, "CHUOI IN HOA: $"
    msg3 db 10, 13, "chuoi in thuong: $"
    
.code
main proc
    mov ax, @data
    mov ds, ax
    mov bl, 0
    mov cx, len
    
    lea di, upper
    lea si, lower
    
    inchuoi msg1
    
l: 
    mov ah, 01h
    int 21h
    
    cmp al, 0Dh
    jz exit
    
    cmp al, 60h
    jl up
    jg lo
    
    loop l
    jmp exit

up: 
    mov [di], al
    add al, 20h
    mov [si], al
    inc di
    inc si
    loop l
lo: 
    mov [si], al
    sub al, 20h
    mov [di], al
    inc di
    inc si
    loop l  
    
exit:  
  
    mov di, 32h    
    inchuoi msg2
    
    up_output:
        mov dl, [di]
        mov ah, 02h
        int 21h    
        inc di
        loop up_output
    
    mov si, 64h    
    inchuoi msg3
    mov cx, len
    lower_output:
        mov dl, [si]
        mov ah, 02h
        int 21h        
        inc si
        loop lower_output
    
    mov ah, 4Ch
    int 21h
endp main
end main