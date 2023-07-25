DSEG SEGMENT
chuoi dw 100 dup("$")
thefile dw ?

DSEG ENDS
CSEG SEGMENT
ASSUME 
    cs:cseg, ds:dseg
begin: 
    mov ax, dseg
    mov ds, ax 
    
    mov si,0
LAP: 
    MOV AH, 01h ; nhap ky tu
    INT 21H
    CMP AL,0Dh ;check dau enter
    JE STOP
    mov ah,0
    MOV chuoi[SI], Ax
    INC SI
JMP LAP

STOP:   
    mov ah, 3ch ; tao tap tin moi
    lea dx, chuoi
    mov cx, 0 ; thuoc tinh tap tin
    int 21h
    mov thefile, ax ; cat the file
    mov ah, 3eh ; dong tap tin
    mov bx, thefile
    int 21h
     
    mov ah, 4ch ; thoat ve Dos
    int 21h
CSEG ENDS
END begin