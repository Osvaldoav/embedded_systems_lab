@ ---------------------------------------
@       Data Section
@ ---------------------------------------
        		.data
		.balign 4
string: 	.asciz “result is: %d\n”
a:      		.word	LAST TWO DIGITS OF ID STUDENT ‘A’
b:		.word 	LAST TWO DIGITS OF ID STUDENT ‘B’   
c:		.word  0

@ ---------------------------------------
@       Code Section
@ ---------------------------------------
        	.text
.global main
.extern printf

main:
	push {ip,lr}		@ push return address + dummy register
@ ---------------------------------------
COMPLETE THE CODE IN ASSEMBLY FOR THE NEXT C STATEMENT

x = ( a + b ) - c;
@ ---------------------------------------
LDR r0,=string	@ get address of string into r0
	LDR r1,=c
	LDR r1,[r1]
	bl printf		@ print string and pass param into r1
	pop {ip,pc}		@ pop return address into pc