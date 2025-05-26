.model small
.stack 100h

.data
; ========== Giao di?n ==========
gameTitle       db '===============================================$'
welcome     db '*           CHUONG TRINH MAY TINH ASM          *$'
team        db '*                 TEAM 8 - PROJECT              *$'
menu        db 'MENU CHINH:$'
opt1        db '1. Thuc hien phep tinh$'
opt2        db '2. Huong dan su dung$'
opt3        db '3. Thoat$'
choiceMsg   db 'Nhap lua chon (1-3): $'
guidegameTitle  db '========== HUONG DAN SU DUNG ==========$'
guideA      db 'Nhap 2 so va toan tu (+ - * /) de tinh toan.$'
guideB      db 'Neu toan tu sai hoac chia 0, chuong trinh se thong bao.$'
pressAny    db 'Nhan phim bat ky de quay lai menu...$'

; ========== Bi?n x? l� ==========
s1      db 6 dup(?)          
s2      db 6 dup(?)       
number1 dw 0                 
number2 dw 0               
operator db ?               
result  dw 0                
error   db 'Loi: Toan tu khong hop le hoac chia 0.$'
error_toantu db 'Toan tu khong hop le, vui long nhap lai (+ - * /).$'
guide1  db 'Nhap vao so thu nhat: $'
guide2  db 'Nhap vao toan tu (+ - * /): $'
guide3  db 'Nhap vao so thu hai: $'
ans     db 'Ket qua la: $'

.code
Main proc
    mov ax, @data
    mov ds, ax

main_menu:
    call clearScr
    call newline
    lea dx, gameTitle
    mov ah, 09h
    int 21h
    call newline
    lea dx, welcome
    mov ah, 09h
    int 21h
    call newline
    lea dx, team
    mov ah, 09h
    int 21h
    call newline
    lea dx, gameTitle
    mov ah, 09h
    int 21h

    call newline
    call newline
    lea dx, menu
    mov ah, 09h
    int 21h
    call newline
    lea dx, opt1
    mov ah, 09h
    int 21h
    call newline
    lea dx, opt2
    mov ah, 09h
    int 21h
    call newline
    lea dx, opt3
    mov ah, 09h
    int 21h

    call newline
    lea dx, choiceMsg
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    cmp al, '1'
    je tinhtoan
    cmp al, '2'
    je huongdan
    cmp al, '3'
    je ketthuc
    jmp main_menu

huongdan:
    call clearScr
    call newline
    lea dx, guidegameTitle
    mov ah, 09h
    int 21h
    call newline
    call newline
    lea dx, guideA
    mov ah, 09h
    int 21h
    call newline
    lea dx, guideB
    mov ah, 09h
    int 21h
    call newline
    call newline
    lea dx, pressAny
    mov ah, 09h
    int 21h
    mov ah, 1
    int 21h
    jmp main_menu

tinhtoan:
    call clearScr
    call newline
    lea dx, guide1
    mov ah, 09h
    int 21h  
    lea di, s1
    call read_number
    lea si, s1
    call atoi
    mov number1, ax

valipInp:
    call newline
    lea dx, guide2
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    mov operator, al

check_operator:
    cmp operator, '+'
    je toantu_ok
    cmp operator, '-'
    je toantu_ok
    cmp operator, '*'
    je toantu_ok
    cmp operator, '/'
    je toantu_ok

    call newline
    lea dx, error_toantu
    mov ah, 09h
    int 21h
    jmp valipInp

toantu_ok:
    call newline
    lea dx, guide3
    mov ah, 09h
    int 21h
    lea di, s2
    call read_number
    lea si, s2
    call atoi
    mov number2, ax

    mov ax, number1
    mov bx, number2

    cmp operator, '+'
    je cong
    cmp operator, '-'
    je tru
    cmp operator, '*'
    je nhan
    cmp operator, '/'
    je chia
    jmp loi_op

cong:
    add ax, bx
    mov result, ax
    jmp in_ans

tru:
    sub ax, bx
    mov result, ax
    jmp in_ans

nhan:
    mul bx
    mov result, ax
    jmp in_ans

chia:
    cmp bx, 0
    je loi_op
    xor dx, dx
    div bx
    mov result, ax
    jmp in_ans

loi_op:
    call newline
    mov ah, 09h
    lea dx, error
    int 21h
    jmp main_menu

in_ans:
    call newline
    lea dx, ans
    mov ah, 09h
    int 21h
    mov ax, result
    call print_num
    call newline
    lea dx, pressAny
    mov ah, 09h
    int 21h
    mov ah, 1
    int 21h
    jmp main_menu

ketthuc:
    mov ah, 4Ch
    int 21h

; ==== SUBROUTINES ====
clearScr:
    mov ax,3
    int 10h
ret

newline:
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
ret

read_number:
    xor cx, cx
read_loop:
    mov ah, 01h
    int 21h
    cmp al, 13
    je done_input
    mov [di], al
    inc di
    inc cx
    cmp cx, 5
    je done_input
    jmp read_loop
done_input:
    mov byte ptr [di], 0
ret

atoi:
    xor ax, ax
    mov bx, 10
next_digit:
    mov cl, [si]
    cmp cl, 0
    je done_conv
    sub cl, '0'
    xor ch, ch
    push ax
    mul bx
    pop dx
    add ax, cx
    inc si
    jmp next_digit
done_conv:
ret

print_num:
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov bx, 10
    cmp ax, 0
    jne chialai
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp done

chialai:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chialai

hienthi:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop hienthi

done:
    call newline
    pop dx
    pop cx
    pop bx
    pop ax
ret

Main endp
END MAIN