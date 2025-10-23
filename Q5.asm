; 第05题：现有一组字符串为data,name,time,file,code,path,user,exit,quit,text，
; 请编写程序从键盘输入4个字符的字符串，若存在将其删除, 并在显示器上显示。
; Coded by: Mosles Signall
; Date: 2025-Oct-23

DATAS SEGMENT
    ERROR DB "ERROR: THE WORD DOESN'T EXIST.",10,13,'$'
    RESUT DB "THE WORD EXISTS. THE RESULT IS: ",10,13,'$'
    EXPECTED DB 0,0,0,0,'$'
    ARRAY DB "data,name,time,file,code,path,user,exit,quit,text",10,13,'$'
    DISK DB "disk",'$'
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

    MOV SI,OFFSET EXPECTED
    MOV AH,1
    MOV CX,4
INPUT:
    INT 21H
    MOV [SI],AL
    INC SI
    LOOP INPUT
    MOV DL,0AH
    MOV AH,2
    INT 21H

SEARCH:
    MOV SI,OFFSET ARRAY
    MOV BX,OFFSET EXPECTED
SEARCH_LOOP:
    MOV DL,[SI]
    MOV AL,[BX]
    CMP DL,AL
    JE PROABLE
    END_PROABLE:
    INC SI
    CMP DL,0DH
    JE NOT_EXIST
    JMP SEARCH_LOOP

DELETE:
    MOV BX,SI
    ADD BX,5
    MOV AL,[BX]
    MOV [SI],AL
    INC SI
    CMP AL,24H
    JNE DELETE

OUTPUT:
    MOV AH,9
    MOV DX,OFFSET ARRAY
    INT 21H

EXIT:    
    MOV AH,4CH
    INT 21H

PROABLE:
    PUSH SI
    PUSH BX
    MOV CX,4
    PROABLE_LOOP:
        MOV DL,[SI]
        MOV DH,[BX]
        CMP DL,DH
        JNE END_PROABLE_LOOP
        INC SI
        INC BX
        LOOP PROABLE_LOOP
        SUB SI,4
        JMP DELETE

END_PROABLE_LOOP:
    POP BX
    POP SI
    JMP END_PROABLE

NOT_EXIST:
    MOV AH,9
    MOV DX,OFFSET ERROR
    INT 21H
    JMP EXIT

CODES ENDS
    END START