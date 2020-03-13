@ ---------------------------------------
@       Data Section
@ ---------------------------------------
		.data
		.balign 4
string:		.asciz "result is: %d\n"
x:		.word 8 
a:		.word 28
b:		.word 60   
c:		.word 9

@ ---------------------------------------
@       Code Section
@ ---------------------------------------
        .text
	.global main
	.extern printf

main:
	push {ip,lr}		@ push return address + dummy register
@ ---------------------------------------
@COMPLETE THE CODE IN ASSEMBLY FOR THE NEXT C STATEMENT
@
@x = (a << 2)|(b & 15);
	LDR r2,=a
	LDR r2,[r2]
	LSL r2, r2, #2
	LDR r3,=b
	LDR r3,[r3]
	AND r3, r3, #15
	ORR r2, r2, r3
	LDR r3,=x
	STR r2,[r3]
@ ---------------------------------------
	LDR r0,=string	@ get address of string into r0
	LDR r1,=x
	LDR r1,[r1]
	bl printf		@ print string and pass param into r1
	pop {ip,pc}		@ pop return address into pc
