inchuoi MACRO chuoi
mov ah, 09h
lea dx, chuoi 
int 21h
endm
dseg segment 
    max db 50
    len db ?
    chuoi db 50 dup(?)

    tb2 db 10,13, 'Chuoi dao nguoc:$'
dseg ends  
cseg segment
assume cs: cseg, ds: cseg
start:  
    mov ax,dseg
    mov ds, ax

    mov ah, 0Ah
    lea dx, max
    int 21h

    inchuoi tb2

    xor cx, cx  
    mov cl, len
    lea si, chuoi

lap:
    push [si]  
    inc si
    loop lap

    mov cl, len
lap2: 
    pop dx 
    mov ah, 02h
    int 21h
    loop lap2

    mov ah, 4Ch 
    int 21h

cseg ends
end start