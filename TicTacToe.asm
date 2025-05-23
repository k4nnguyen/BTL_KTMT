.Model Small
.Stack 100H
.Data

arr db '1','2','3'
    db '4','5','6'
    db '7','8','9'
crlf db 13,10,'$'
introMsg db 'Chao mung den voi Tic Tac Toe! $'
choiceMsg db 'Lua chon vi tri danh dau, ban la nguoi choi $'
resultMsg db 'Nguoi choi thang la: $'
drawMsg db 'Hoa! $'
wrongInput db 'Ban da nhap sai ki tu! Vui long nhap lai: $'
takenBox db 'O nay da duoc chon roi! Vui long nhap lai. $'
player db ? 
.Code
Main proc
    mov ax,@data
    mov ds,ax
    
    mov cx,9 ; toi da 9 luot choi
    x: ; dung de lap luot choi
        cmp cx,0
        je endGame
        ; Kiem tra neu cx = 0 -> end
        call clearScr 
        call printIntroMsg
        call printArr
        
        mov bx,cx
        and bx,1
        ; Nhan bx voi 00001, neu so le -> bx = 1, chan -> bx = 0
        cmp bx,0
        je isEven
        mov player, 'x'
        jmp endif
        
        isEven:
        mov player,'o'
        ; o la nguoi choi chan, x la nguoi choi le
        
        endif:
        
        inValid:
        call endLine
        call printChoiceMsg
        call readInput
        
        mov bl,al
        sub bl,'1' ; chuyen '1' -> '9' thanh 0 -> 8 (index)
        cmp arr[bx],'x'
        je alreadyTaken
        cmp arr[bx],'o'
        je alreadyTaken
        ; Kiem tra o do da duoc danh dau chua
        
        mov dl,player
        mov arr[bx],dl
        call checkWin
        
        dec cx
        jmp x
        
        alreadyTaken:
            call endLine
            call printTakenMsg
            jmp inValid
        endGame:
        call endLine
        call printArr
        call printDraw ; Neu loop xong khong ai win -> hoa
           
           
        ; Functions() ===================================================================================================
        
        endProgram: ; Ket thuc chuong trinh
            mov ah,4ch
            int 21h
        ret
        
        clearScr:
            mov ax,3 ; clear man hinh trong ascii
            int 10h  ; goi ham ngat 10h
        ret
        
        endLine:
            lea dx,crlf
            mov ah,9
            int 21h
        ret       
        
        readInput:
            mov ah,1
            int 21h
            
            cmp al,'1'
            je valid
            cmp al,'2'
            je valid
            cmp al,'3'
            je valid
            cmp al,'4'
            je valid
            cmp al,'5'
            je valid
            cmp al,'6'
            je valid
            cmp al,'7'
            je valid
            cmp al,'8'
            je valid
            cmp al,'9'
            je valid
            
            call printWrongInput
            jmp readInput
            valid:
        ret
        
        printSpace:
            mov dl,32 ; ki tu space trong ascii
            mov ah,2
            int 21h
        ret            
        
        printIntroMsg:
            lea dx, introMSG
            mov ah,9
            int 21h ; Goi ham ngat 21h
            ; In intro mo dau
        ret
        
        printChoiceMsg:
            lea dx,choiceMsg
            mov ah,9
            int 21h
            mov dl,player
            mov ah,2
            int 21h
            
            mov dl,58 ; in dau ':'
            mov ah,2
            int 21h
            
            call printSpace
        ret                
        
        printWrongInput:
            call endLine
            call endLine
            lea dx,wrongInput
            mov ah,9
            int 21h
            call endLine
            lea dx,choiceMsg
            mov ah,9
            int 21h
            mov dl,player
            mov ah,2
            int 21h  
            
            mov dl,58 ; in dau ':'
            mov ah,2
            int 21h
            
            call printSpace
        ret 
        
        printTakenMsg:
            call endLine
            lea dx,takenBox
            mov ah,9
            int 21h
           
        ret 
        
        printArr:
            push cx
            mov bx,0
            mov cx,3
            ; lap mang 3x3
        x1:
            call endLine
            push cx
            mov cx,3
            x2:
                mov dl,arr[bx]
                mov ah,2h ; de in ki tu
                int 21h
                call printSpace
                inc bx
            loop x2
            pop cx
        loop x1
        pop cx
        call endLine
      ret
         
         printDraw:
            call endLine
            lea dx,drawMsg
            mov ah,9
            int 21h
        ret
         
         printWin:
            call endLine
            call printArr
            lea dx,resultMsg
            mov ah,9
            int 21h
            ; In ra thong bao ket qua
            mov dl, player
            mov ah,2h
            int 21h
            ; In ra nguoi choi thang
            jmp endProgram
         ret
         
         checkWin: ; kiem tra dieu kien win
            mov bl,arr[0]
            cmp bl,arr[1]
            jne skip1
            cmp bl,arr[2]
            jne skip1
            call printWin
            
            skip1:
            mov bl,arr[3]
            cmp bl,arr[4]
            jne skip2
            cmp bl,arr[5]
            jne skip2
            call printWin
            
            skip2:
            mov bl,arr[6]
            cmp bl,arr[7]
            jne skip3
            cmp bl,arr[8]
            jne skip3
            call printWin
         
            skip3:
            mov bl,arr[0]
            cmp bl,arr[3]
            jne skip4
            cmp bl,arr[6]
            jne skip4
            call printWin
            
            skip4:
            mov bl,arr[1]
            cmp bl,arr[4]
            jne skip5
            cmp bl,arr[7]
            jne skip5
            call printWin
            
            skip5:
            mov bl,arr[2]
            cmp bl,arr[5]
            jne skip6
            cmp bl,arr[8]
            jne skip6
            call printWin
            
            skip6:
            mov bl,arr[0]
            cmp bl,arr[4]
            jne skip7
            cmp bl,arr[8]
            jne skip7
            call printWin
            
            skip7:
            mov bl,arr[2]
            cmp bl,arr[4]
            jne skip8
            cmp bl,arr[6]
            jne skip8
            call printWin
            
            skip8:
          ret
        
            
                
Main endp
END MAIN