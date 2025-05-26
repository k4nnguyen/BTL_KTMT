.Model Small
.Stack 100H
.Data

arr db '1','2','3'
    db '4','5','6'
    db '7','8','9'
crlf db 13,10,'$'

; Giao di?n messages
gameTitle db  '************************************************$'
welcomeMsg db '*          CHAO MUNG DEN VOI TIC TAC TOE       *$'
teamMsg db    '*              TEAM 8 - ASM PROJECT            *$'
menuMsg db 'MENU CHINH:$'
option1 db '1. Bat dau tro choi 2 nguoi$'
option2 db '2. Huong dan choi$'
option3 db '3. Thoat$'
choicePrompt db 'Lua chon cua ban (1-3): $'
instructionTitle db '============== HUONG DAN CHOI ==============$'
instruction1 db 'Game danh cho 2 nguoi choi$'
instruction2 db 'Nguoi choi 1: X, Nguoi choi 2: O$'
instruction3 db 'Nhap so tu 1-9 de danh dau vi tri$'
instruction4 db 'Muc tieu: Tao duong thang 3 dau X hoac O$'
instruction5 db 'Vi tri duoc danh so nhu sau:$'
backToMenu db 'Nhan phim bat ki de quay lai menu...$'

gameHeader db '=============== TIC TAC TOE ===============$'
boardFrame db    '+-------+-------+-------+$'
boardSide db '|       |       |       |$'

player1TurnMsg db 'Luot cua Nguoi choi 1 (X): $'
player2TurnMsg db 'Luot cua Nguoi choi 2 (O): $'
choiceMsg db 'Chon vi tri (1-9): $'
resultMsg db 'KET QUA: $'
player1WinMsg db 'CHUC MUNG! NGUOI CHOI 1 (X) DA THANG!$'
player2WinMsg db 'CHUC MUNG! NGUOI CHOI 2 (O) DA THANG!$'
drawMsg db 'HOA! KHONG AI THANG!$'
wrongInput db 'Nhap sai! Vui long nhap so tu 1-9: $'
takenBox db 'Vi tri da duoc chon! Chon vi tri khac: $'
continueMsg db 'Nhan phim bat ki de tiep tuc...$'
currentPlayer db 'X'    ; Nguoi choi hien tai
gameWon db 0           ;  Trang thai thang

.Code
Main proc
    mov ax,@data
    mov ds,ax
    
    mainMenu:
        call clearScr
        call showMainMenu
        call readMenuChoice
        
        cmp al,'1'
        je startGame
        cmp al,'2'
        je showInstructions
        cmp al,'3'
        je exitProgram
        jmp mainMenu
        
    startGame:
        call playTicTacToe
        jmp mainMenu
        
    showInstructions:
        call displayInstructions
        jmp mainMenu
        
    exitProgram:
        call clearScr
        mov ah,4ch
        int 21h
Main endp

; =============== MENU FUNCTIONS ===============
showMainMenu:
    call endLine
    lea dx,gameTitle
    mov ah,9
    int 21h
    
    call endLine
    lea dx,welcomeMsg
    mov ah,9
    int 21h 
    
    call endLine
    lea dx,teamMsg
    mov ah,9
    int 21h
    
    call endLine
    lea dx,gameTitle
    mov ah,9
    int 21h 
    
    call endLine
    call endLine
    
    lea dx,menuMsg
    mov ah,9
    int 21h 
    
    call endLine
    lea dx,option1
    mov ah,9
    int 21h
    
    call endLine
    lea dx,option2
    mov ah,9
    int 21h  
    
    call endLine
    lea dx,option3
    mov ah,9
    int 21h
    call endLine
    call endLine
ret

readMenuChoice:
    lea dx,choicePrompt
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je validChoice
    cmp al,'2'
    je validChoice
    cmp al,'3'
    je validChoice
    
    call endLine
    lea dx,wrongInput
    mov ah,9
    int 21h 
    
    call endLine
    jmp readMenuChoice
    
    validChoice:
ret

displayInstructions:
    call clearScr
    call endLine
    lea dx,instructionTitle
    mov ah,9
    int 21h 
    
    call endLine
    call endLine
    
    lea dx,instruction1
    mov ah,9
    int 21h  
    
    call endLine
    lea dx,instruction2
    mov ah,9
    int 21h  
    
    call endLine
    lea dx,instruction3
    mov ah,9
    int 21h 
    
    call endLine
    lea dx,instruction4
    mov ah,9
    int 21h
    call endLine
    call endLine
    
    lea dx,instruction5
    mov ah,9
    int 21h
    call endLine
    call endLine
    
    call printSampleBoard
    call endLine
    call waitForKey
ret

printSampleBoard:
    lea dx,boardFrame
    mov ah,9
    int 21h
    call endLine
    
    ; Hàng 1
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'1'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'2'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'3'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call endLine
    lea dx,boardFrame
    mov ah,9
    int 21h  
    
    call endLine
    
    ; Hàng 2
    mov dl,'|'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'4'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h
    
    call printSpaces3
    mov dl,'5'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'6'
    mov ah,2
    int 21h  
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call endLine
    
    lea dx,boardFrame
    mov ah,9
    int 21h
    call endLine
    
    ; Hàng 3
    mov dl,'|'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'7'
    mov ah,2
    int 21h
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'8'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h 
    
    call printSpaces3
    mov dl,'9'
    mov ah,2
    int 21h
    
    call printSpaces3
    mov dl,'|'
    mov ah,2
    int 21h  
    
    call endLine
    
    lea dx,boardFrame
    mov ah,9
    int 21h 
    
    call endLine
ret

; =============== GAME FUNCTIONS ===============
playTicTacToe:
    ; Reset board
    mov arr[0],'1'
    mov arr[1],'2'
    mov arr[2],'3'
    mov arr[3],'4'
    mov arr[4],'5'
    mov arr[5],'6'
    mov arr[6],'7'
    mov arr[7],'8'
    mov arr[8],'9'
    
    mov currentPlayer,'X'  ; Nguoi choi 1 bat dau
    mov gameWon,0          
    mov cx,9               
    
    gameLoop:
        cmp gameWon,1      ; Kiem tra neu co ng thang
        je endGame
        cmp cx,0           
        je endGameDraw
        
        call clearScr
        call printGameScreen
        
        ; Hien ng choi
        call showCurrentPlayerTurn
        call playerMove
        call checkWin
        
        ; Chuyen luot
        cmp gameWon,1      
        je gameLoop
        call switchPlayer
        
        dec cx
        jmp gameLoop
        
    endGameDraw:
        call clearScr
        call printGameScreen
        call endLine
        lea dx,drawMsg
        mov ah,9
        int 21h
        call endLine
        call waitForKey
        ret
        
    endGame:
ret


showCurrentPlayerTurn:
    call endLine
    cmp currentPlayer,'X'
    je showPlayer1Turn
    
    lea dx,player2TurnMsg
    mov ah,9
    int 21h
    jmp endShowTurn
    
    showPlayer1Turn:
    lea dx,player1TurnMsg
    mov ah,9
    int 21h
    
    endShowTurn:
    call endLine
ret

switchPlayer:
    cmp currentPlayer,'X'
    je switchToO
    
    mov currentPlayer,'X'
    ret
    
    switchToO:
    mov currentPlayer,'O'
ret

printGameScreen:
    call endLine
    lea dx,gameHeader
    mov ah,9
    int 21h
    call endLine
    call endLine
    call printBoard
    call endLine
ret

printBoard:
    push cx
    push bx
    
    lea dx,boardFrame
    mov ah,9
    int 21h
    call endLine
    
    mov bx,0
    mov cx,3
    
    rowLoop:
        push cx
        
        mov dl,'|'
        mov ah,2
        int 21h

        mov cx,3
        colLoop:
            call printSpaces3
            mov dl,arr[bx]
            mov ah,2
            int 21h
            call printSpaces3
            mov dl,'|'
            mov ah,2
            int 21h
            inc bx
        loop colLoop
        call endLine 
        pop cx
        
        cmp cx,1
        je skipMidFrame
        lea dx,boardFrame
        mov ah,9
        int 21h
        call endLine
        
        skipMidFrame:
    loop rowLoop
    
    lea dx,boardFrame
    mov ah,9
    int 21h
    call endLine
    
    pop bx
    pop cx
ret

playerMove:
    invalidMove:
    lea dx,choiceMsg
    mov ah,9
    int 21h
    call readInput
    
    mov bl,al
    sub bl,'1'
    cmp bl,9           ; Kiem tra gioi han
    jge invalidMove
    cmp arr[bx],'X'
    je alreadyTaken
    cmp arr[bx],'O'
    je alreadyTaken
    
    mov dl,currentPlayer
    mov arr[bx],dl
    ret
    
    alreadyTaken:
        call endLine
        lea dx,takenBox
        mov ah,9
        int 21h   
        
        call endLine
        jmp invalidMove
ret

; =============== UTILITY FUNCTIONS ===============
clearScr:
    mov ax,3
    int 10h
ret

endLine:
    lea dx,crlf
    mov ah,9
    int 21h
ret

waitForKey:
    call endLine
    lea dx,continueMsg
    mov ah,9
    int 21h   
    
    mov ah,1
    int 21h
ret

readInput:
    mov ah,1
    int 21h
    
    cmp al,'1'
    jl invalidInput
    cmp al,'9'
    jg invalidInput
    ret
    
    invalidInput:
    call endLine
    lea dx,wrongInput
    mov ah,9
    int 21h
    call endLine
    jmp readInput
ret

printSpaces3:
    mov dl,32
    mov ah,2
    int 21h
    mov ah,2
    int 21h
    mov ah,2
    int 21h
ret

checkWin:
    push cx
    
    ; Kiem tra hàng ngang
    mov bl,arr[0]
    cmp bl,arr[1]
    jne check2
    cmp bl,arr[2]
    jne check2
    call printWin
    jmp endCheckWin
    
    check2:
    mov bl,arr[3]
    cmp bl,arr[4]
    jne check3
    cmp bl,arr[5]
    jne check3
    call printWin
    jmp endCheckWin
    
    check3:
    mov bl,arr[6]
    cmp bl,arr[7]
    jne check4
    cmp bl,arr[8]
    jne check4
    call printWin
    jmp endCheckWin
    
    ; Kiem tra hàng doc
    check4:
    mov bl,arr[0]
    cmp bl,arr[3]
    jne check5
    cmp bl,arr[6]
    jne check5
    call printWin
    jmp endCheckWin
    
    check5:
    mov bl,arr[1]
    cmp bl,arr[4]
    jne check6
    cmp bl,arr[7]
    jne check6
    call printWin
    jmp endCheckWin
    
    check6:
    mov bl,arr[2]
    cmp bl,arr[5]
    jne check7
    cmp bl,arr[8]
    jne check7
    call printWin
    jmp endCheckWin
    
    ; Kiem tra duong cheo
    check7:
    mov bl,arr[0]
    cmp bl,arr[4]
    jne check8
    cmp bl,arr[8]
    jne check8
    call printWin
    jmp endCheckWin
    
    check8:
    mov bl,arr[2]
    cmp bl,arr[4]
    jne endCheckWin
    cmp bl,arr[6]
    jne endCheckWin
    call printWin
    
    endCheckWin:
    pop cx
ret

printWin:
    mov gameWon,1
    call clearScr
    call printGameScreen
    call endLine
    lea dx,resultMsg
    mov ah,9
    int 21h
    call endLine
    
    cmp currentPlayer,'X'
    je player1Wins
    
    lea dx,player2WinMsg
    mov ah,9
    int 21h
    jmp endWin
    
    player1Wins:
    lea dx,player1WinMsg
    mov ah,9
    int 21h
    
    endWin:
    call endLine
    call waitForKey
ret

END Main