@ ---------------------------------------
@       Data Section
@ ---------------------------------------
		.data
		.balign 4
string:		.asciz "result is: x= %d y= %d\n"
x:		.word 8 
a:		.word 60
b:		.word 28   
y:		.word 9

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
@if(a > b) {
@	x = 5;
@	y = a + b;
@}
@else
@	x = a - b;

	LDR r2,=a
	LDR r2,[r2]
	LDR r3,=b
	LDR r3,[r3]

	MOV r5,#0
	CMP r2, r3
	MOVGT r4, #5
	ADDGT r5, r2, r3
	SUBLE r4, r2, r3
	
	LDR r3,=x
	STR r4,[r3]
	LDR r3,=y
	STR r5,[r3]
@ ---------------------------------------
	LDR r0,=string	@ get address of string into r0
	LDR r1,=x
	LDR r1,[r1]
	LDR r2,=y
	LDR r2,[r2]
	bl printf		@ print string and pass param into r1
	pop {ip,pc}		@ pop return address into pc
