@ ---------------------------------------
@       Data Section
@ ---------------------------------------
		.data
		.balign 4
string:		.asciz "result is: %d\n"
x:		.word 0 
a:		.word 28
b:		.word 60   
c:		.word 0

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
@x = ( b + c ) * a;
	LDR r2,=b
	LDR r2,[r2]
	LDR r3,=c
	LDR r3,[r3]
	ADD r2,r2,r3
	LDR r3,=a
	LDR r3,[r3]
	MUL r4,r2,r3
	LDR r3,=x
	STR r4,[r3]
@ ---------------------------------------
	LDR r0,=string	@ get address of string into r0
	LDR r1,=x
	LDR r1,[r1]
	bl printf		@ print string and pass param into r1
	pop {ip,pc}		@ pop return address into pc
