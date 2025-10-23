; 第02题：请任意输入一个字符串，将其中大写字母换成小写字母，并将结果显示在屏幕上。
; Coded by: Mosles Signall
; Date: 2025-Oct-23
DATAS SEGMENT
    
DATAS ENDS

STACKS SEGMENT
    DW 100 DUP(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

    MOV SI,0
    MOV AH,1

INPUT:
    INT 21H
    CMP AL,0DH
    JE INPUT_END
    CMP AL,41H
    JB UPLOAD
    CMP AL,5AH
    JA UPLOAD
    ADD AL,20H

UPLOAD:
    MOV [SI],AL
    INC SI
    JMP INPUT

INPUT_END:
    INC SI
    MOV AL,24H
    MOV [SI],AL
    
    MOV DX,0
    MOV AH,9
    INT 21H

EXIT:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START