inchuoi MACRO chuoi
MOV AH, 9h
LEA DX, chuoi
INT 21h
ENDM 

inchuoi2 MACRO chuoi
MOV AH, 9h
LEA DL, chuoi
INT 21h
ENDM 
DSEG SEGMENT 
    string1 db 100 dup(0)    
    msg1 DB "Ten file: $"
    chuoi dw 100 dup(?),0 
    ND db 10,13, 'Noi dung: $'    
    thefile dw ?

DSEG ENDS
CSEG SEGMENT
ASSUME cs:cseg, ds:dseg
begin: 
    mov ax, dseg
    mov ds, ax 

    inchuoi msg1
    mov si,0
LAP: 
    MOV AH, 01h     ; nhap ky tu
    INT 21H
    CMP AL, 0Dh     ;check dau enter
    JE STOP
    mov ah,0
    MOV chuoi[SI], Ax
    INC SI
JMP LAP

STOP:
    inchuoi ND

    MOV SI, 0       ; chi so mang
    MOV CX, 100     ; do dai mang max
LAP1:               
    MOV AH, 1       ; nhap ky tu
    INT 21H
    CMP AL,0Dh      ; check dau enter
    JE STOP1
    MOV string1[SI], AL
    INC SI
JMP LAP1 


STOP1: 
    mov ah, 3ch     ; tao tap tin moi
    lea dx, chuoi
    mov cx, 0       ; thuoc tinh tap tin
    int 21h 
    mov cx, si
    mov thefile, ax ; cat the file
    
    mov ah, 40h     ; ghi file
    mov bx, thefile
 
GHI_FILE:
    ;xor cx, cx
    ;mov cl, len
    mov dh,0
    mov dl, string1[SI]
    int 21h
LOOP GHI_FILE

    mov ah, 3eh     ; dong tap tin
    mov bx, thefile 

    int 21h
    mov ah, 4ch     ; thoat ve Dos
    int 21h
cseg ends
end begin
