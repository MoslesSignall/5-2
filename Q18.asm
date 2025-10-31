; 第18题：一个有符号字数组以0为结束标志，编程求这个数组的最大值、最小值、平均值。
; Coded by: Mosles Signall
; Date: 2025-Oct-31

DATAS SEGMENT
    NUMBER DW 100,-120,66,175,17782,-20156,31209,0
    MAX DW -32768
    MIN DW 32767
    ADDITION DW 0
    LEN DW 0
    WARNING DB "ERROR, OVERFLOW HAPPENED!",13,10,'$'
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

READ:
    MOV AX,NUMBER[SI]
    CMP AX,0
    JE DISPLAY
    CMP AX,MAX
    JG CHANGE_MAX
    CMP AX,MIN
    JL CHANGE_MIN
    ADD ADDITION,AX
    INC LEN
    ADD SI,2
    JMP READ

DISPLAY:
    MOV AX,ADDITION
    MOV BX,LEN
    MOV DX,0
    DIV BX
    MOV ADDITION,AX
    MOV DX,MAX
    CALL SHOW
    MOV DX,MIN
    CALL SHOW
    MOV DX,ADDITION
    CALL SHOW

EXIT:
    MOV AH,4CH
    INT 21H

CHANGE_MAX:
    MOV MAX,AX
    JMP READ

CHANGE_MIN:
    MOV MIN,AX
    JMP READ

SHOW PROC
    CMP DX,0
    JL NEGITIVE
    NEGITIVE_ENDS:
    MOV BX,10
    MOV CX,0
    MOV AX,DX
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

NEGITIVE:
    PUSH AX
    PUSH DX
    MOV AH,2
    MOV DX,'-'
    INT 21H
    POP DX
    POP AX
    NEG DX
    JMP NEGITIVE_ENDS
SHOW ENDP
CODES ENDS
    END START