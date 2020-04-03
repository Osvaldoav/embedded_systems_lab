@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
.data
.balign 4	
string: .asciz "\n%d + %d = %d\n"
y:	.word	0

@ ---------------------------------------
@	Code Section
@ ---------------------------------------
	
.text
.global main
.extern printf

main:   
LDR r2,=y
LDR r1,=0xAAAAAAAA
STR r1, [r2]
LDR r1,=0xBBBBBBBB
STR r1, [r2], #4
LDR r1,=0xCCCCCCCC
STR r1, [r2, #-4]!
