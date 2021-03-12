dda equ  7b00h

AV      equ 40960




jmp ees
oem             db      "MY OEM  "
bsector         dw      200h
scluster        db      1h 
rsector         dw      1h
tfat            db      2h
rent            dw      0e0h
tsectors        dw      0b40h
media           db      0f0h 
sfat            dw      9h
strak           dw      12h
head            dw      2h
hidden          dd      0h
large           dd      0h
drive           db      0h
flag            db      0h
sig             db      29h
vol             dd      0ffffffffh
label           db      "MY LABEL    "
id              db      "FAT12   "
nop
ees:


        mov ax,3
int 10h



@llop2:
call check
cmp al,0
jz @llop2

        mov ax,1000h
        mov es,ax
        mov ax,19

call func


mov bp,100h

@mloop:
mov al,es:[bp]
cmp al,35
jz @mloop1
add bp,32
cmp bp,300h
jb @mloop  
jmp myloop

@mloop1:
        add bp,1ah
        mov ax,es:[bp]
        add ax,31
call func


mov ax,1000h
mov es,ax
mov ds,ax

jmp far 1000h:100h


@myloop:
call check
cmp al,0
jnz @myloop





        mov ax,202
int 19h



xor ah,ah
int 21h
ret



check:
        in al,60h
        and al,128
        ret

func:
        push bp
        push dx
        push cx
        push bx
        push ax
        
        xor dx,dx
        xor cx,cx
        mov bx,36
        clc
        idiv bx
        push ax
        mov ax,dx

        xor dx,dx
        xor cx,cx
        mov bx,18
        clc
        idiv bx
        push ax
        mov ax,dx
        inc dx
        mov cl,dl
        pop ax
        mov dh,al
        pop ax
        mov ch,al
        
        
        

        mov ax,1000h
        mov bx,100h
        mov es,ax
        mov al,30
        mov ah,2
        mov dl,0

int 13h
        

        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret




print:
        mov dh,0
        mov dl,0
        mov cx,512
        mov bp,100h 
        
        mov bl,50h
        mov ah,13h
        mov al,0
        mov bh,0

int 10h
ret

