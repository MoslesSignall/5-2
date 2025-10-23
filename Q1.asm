; QUESTION 01:
; Please enter any string, replace all instances of "A" with "CC", and display the result on the screen.
; Coded by: Mosles Signall
; Date: 2025-Oct-23
DATAS SEGMENT
    CC DB "CC",'$'
DATAS ENDS

STACKS SEGMENT
    DW 100 DUP(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    MOV BX,8000H
    MOV AH,1

INPUT:
    INT 21H
    MOV DX,0
    MOV DL,AL
    MOV [BX],DL
    CMP DL,0DH
    JE END_INPUT
    INC BX
    JMP INPUT

END_INPUT:
    MOV SI,8000H

PRINT:
    MOV DL,[SI]
    MOV AH,2
    CMP DL,41H
    JE PRINT_CC
    INT 21H
    END_PRINT_CC:
    INC SI
    CMP DL,0DH
    JNE PRINT

EXIT:
    MOV AH,4CH
    INT 21H

PRINT_CC:
    MOV AH,9
    MOV DX,OFFSET CC
    INT 21H
    JMP END_PRINT_CC
CODES ENDS
    END START
