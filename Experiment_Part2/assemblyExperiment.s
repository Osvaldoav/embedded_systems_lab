@ ---------------------------------------
@       Data Section
@ ---------------------------------------
        	.data
a:      	.word   0xAABBCCDD

@ ---------------------------------------
@       Code Section
@ ---------------------------------------
        	.text
.global main

main:
        	LDR r1,=a
	MOV r2,#4
	MOV r7,#1
	SUB r3,r1,#4
	ADD r4,r1,#4
	ADD r5,r1,#8
	LDR r6,=0x11223344
	STR r6,[r3]
	LDR r6,=0x55667788
	STR r6,[r4]
	LDR r6,=0x99AABBCC
	STR r6,[r5]	

LDR r0,[r1]		@12th instruction
        	LDR r0,[r1,-r2]	
	LDR r0,[r1,#4]
	LDR r0,[r1,r7,LSL #2]
	LDR r0,[r1,#4]!
	LDR r0,[r1],#8
	bx lr
