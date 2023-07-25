inchuoi MACRO chuoi
MOV AH, 9h
LEA DX, chuoi
INT 21h
ENDM
DSEG SEGMENT
    msg1 DB "Hay nhap 1 ky tu: $"
    msg2 DB "Ma ASCII o dang Hex: $"
    msg3 DB "Ma ASCII o dang Dec: $"
    msg4 DB "Ma ASCII o dang Bin: $"
    xdong DB 10, 13, ‘$’
    kytu DB ?
    
DSEG ENDS
CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG
begin: MOV AX, DSEG
    MOV DS, AX
    inchuoi msg1
    MOV AH, 01h
    INT 21h
    MOV kytu, AL ; cat ky tu nhan duoc 
   
    inchuoi xdong
    inchuoi msg2
    MOV BH, kytu ; Ky tu can in
    CALL hex_out
    MOV AH, 02 ; in ra ky tu h sau so Hex
    MOV DL, 'h'
    INT 21h
      
    inchuoi xdong
    inchuoi msg3
    XOR AX, AX
    MOV AL, kytu
    CALL dec_out
    
    inchuoi xdong
    inchuoi msg3
    MOV BL, kytu 
    CALL bin_out
    MOV AH, 02 ; in ra ky tu b sau so Bin
    MOV DL, 'b'
    INT 21h
    
    Mov Ah, 4Ch
    int 21h
        
hex_out PROC
    MOV CX, 2
xuat_hex:
    PUSH CX
    MOV CL, 4
    MOV DL, BH
    SHR DL, CL
    CMP DL, 09h
    JA nhan
    ADD DL, 30h ; Doi thanh ky tu tu 0-9
    JMP inra
nhan:
    ADD DL, 37h ; Doi thanh ky tu A-F
inra:
    MOV AH, 02h ; In ra màn hinh ky tu da doi
    INT 21h
    SHL BX, CL ; Quay trai BX 4 bit
    POP CX
    LOOP xuat_hex
    RET    
hex_out ENDP

dec_out PROC
    XOR CX,CX       ; CX dem so chu so thap phan
    MOV BX,10
chia10: XOR DX,DX
    DIV BX          ; DX:AX÷BX => AX: Thuong, DX: so du
    PUSH DX         ; Cat so du vào stack
    INC CX
    CMP AX, 0
    JNZ chia10      ; neu AX>0 thi chia tiep cho 10
inra2: 
    MOV AH,2        ; in ra màn hinh
    POP DX          ; lay chu so th?p phan
    ADD DL,30h      ; doi thành ky so
    INT 21h
    LOOP inra2
    RET
dec_out ENDP   

bin_out PROC    
    MOV CX, 8       ; Xuat 8 bit trong BL ra M.Hinh
xuat_bin:
    MOV DL, 0
    SHL BL, 1       ; CF chua MSB, xuat ra màn hinh
    RCL DL, 1       ; Dua CF vào LSB cua DL
    ADD DL, 30h     ; So + 30h = Ky so
    MOV AH, 02h     ; In ra màn hình
    INT 21h
    LOOP xuat_bin
    RET   
bin_out ENDP    
    
CSEG ENDS
END begin



