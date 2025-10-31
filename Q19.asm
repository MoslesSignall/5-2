; 第19题：在BUFFER中定义了的十个带符号字，将其中的负数变成绝对值，并以十进制方式输出。
; Coded by: Mosles Signall
; Date: 2025-Oct-31

DATAS SEGMENT
    NUMBER DW 100,-120,66,175,17782,-20156,31209,-12021,25103,8824
DATAS ENDS

STACKS SEGMENT
    DW 100 DUP(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

START:
    MOV AX, DATAS
    MOV DS, AX
    MOV SI,0
    MOV CX,10

READ:
    PUSH CX
    MOV AX,NUMBER[SI]
    CMP AX,0
    JG DISPLAY
    NEG AX
    DISPLAY:
    CALL SHOW
    ADD SI,2
    POP CX
    LOOP READ

EXIT:
    MOV AH,4CH
    INT 21H

SHOW PROC
    MOV BX,10
    MOV CX,0
    DIVISION:
        MOV DX,0
        DIV BX
        ADD DX,30H
        PUSH DX
        INC CX
        CMP AX,0
        JNE DIVISION
    MOV AH,2
    ON:
        POP DX
        INT 21H
        LOOP ON
    MOV DX,0AH
    INT 21H
    RET
SHOW ENDP   
CODES ENDS
    END START