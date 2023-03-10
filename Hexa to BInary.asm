
;Hexa to binary
.MODEL SMALL
.DATA
M1 DB 0AH,0DH, 'TYPE A HEXA NUMBER: ','$'
M2 DB 0AH,0DH, 'IN BINARY: ','$'
M3 DB 0AH,0DH, 'ILLEGAL HEXA INPUT. TRY AGAIN.','$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS, AX
    
    MOV AH,9
    LEA DX, M1  
    INT 21H
    
 START:
    XOR BX,BX
    MOV CL,4
    MOV AH,1
    INT 21H
    
 WHILE_:
    CMP AL,0DH
    JE END_WHILE
    CMP AL,'0'
    JL ERR
    CMP AL,'9'
    JG LETTER
    AND AL,0FH
    JMP SHIFT
    
 LETTER:
    CMP AL,'F'
    JG ERR
    CMP AL,'A'
    JL ERR
    SUB AL, 37H
    
 SHIFT:
    SHL BX, CL
    OR BL,AL
    INT 21H
    JMP WHILE_  
    
 END_WHILE:
    MOV AH,9
    LEA DX, M2
    INT 21H
    
    MOV CX,16
    MOV AH,2
    
 SHOW:
    SHL BX,1
    JC ONE
    
    MOV DL,'0'
    INT 21H
    JMP LOOP1
    
 ONE:
    MOV DL,'1'
    INT 21H
    
 LOOP1:
    LOOP SHOW
    JMP OUT_
    
 ERR:
    MOV AH,9
    LEA DX,M3
    
    INT 21H
    JMP START
    
 OUT_:
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN




