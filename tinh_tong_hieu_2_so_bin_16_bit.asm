inchuoi MACRO chuoi
    MOV AH, 9h
    LEA DX, chuoi
    INT 21h
ENDM

DSEG SEGMENT
    msg1 DB "Hay nhap so A : $"
    msg2 DB "Hay nhap so B : $"
    msg3 DB "A + B   = $" 
    msg4 DB "A - B   = $"
    msg5 DB "A AND B = $"
    msg6 DB "A OR B  = $"
    msg7 DB "Nhap lai:  $"
    xdong DB 10, 13, '$'
    sohex1 DW ?
    sohex2 dw ?
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG

begin:
    MOV AX, DSEG
    MOV DS, AX
  
    inchuoi msg1
    CALL hex_in
    MOV sohex1, BX
    PUSH BX
      
    inchuoi xdong
    inchuoi msg2
    CALL hex_in
    MOV sohex2, BX
    
    inchuoi xdong
    inchuoi msg3
    ADD BX, sohex1 
    CALL hex_out

    inchuoi xdong
    inchuoi msg4
    POP BX
    SUB BX, sohex2
    CALL hex_out
    
    inchuoi xdong
    inchuoi msg5
    MOV BX, sohex1
    AND BX, sohex2 
    CALL hex_out
    
    inchuoi xdong
    inchuoi msg6
    MOV BX, sohex1
    OR BX, sohex2 
    CALL hex_out
    
         
    MOV AH, 4Ch     ; thoat khoi chuong trinh
    INT 21h


hex_in PROC
    XOR BX, BX      ; Xoa BX
    MOV CX, 16      ; nhap du 16 bit thi dung
    
nhap:
    MOV AH, 01h     ; Ham nhap ki tu
    INT 21h             
   

    CMP AL, 0Dh     ; neu la phim Enter thi thoi nhap
    JZ exit
     
    CMP AL, '0'
    Je xuly
    CMP AL, '1'
    Je xuly
    
    
    XOR BX, BX
    inchuoi xdong
    inchuoi msg7
    jmp nhap

xuly:
    SHL BX, 1       ; Dich trai BX 1 bit
    SUB AL, 30h     ; Ky so - 30h = so
    ADD BL, AL      ; Chuyen so tu AL sang BX luu tru
    LOOP nhap

exit:
    RET
hex_in ENDP

hex_out PROC
    MOV CX, 16      ; Xuat 16 bit trong BX ra M.Hinh
                
xuat:
    MOV DL, 0
    SHL BX, 1       ; CF chia MSB, xuat ra man hinh
    RCL DL, 1       ; dua CF vao LSB cua DX
    ADD DL, 30h     ; So + 30h = Ki so
    MOV AH, 02h     ; In ra man hinh
    INT 21h
    LOOP xuat

    RET
hex_out ENDP




CSEG ENDS
END begin
