dseg segment
tenfile db "D:\data.txt",0
dseg ends
cseg segment
assume cs:cseg, ds:dseg
begin: mov ax, dseg
mov ds, ax
mov ah,41h ; xoa tap tin da co
lea dx, tenfile
int 21h
mov ah, 4ch ; thoat ve Dos
int 21h
cseg ends
end begin