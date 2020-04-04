@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
.data
.balign 4	
func_prompt:	.asciz	"6x^2 + 9x + 2\n"
xprompt:	.asciz	"Enter value for x:\n"
result_prompt:	.asciz	"The result is: %d \n"
format: .asciz 	"%d"

x:		.word	0

@ ---------------------------------------
@	Code Section
@ ---------------------------------------
	
.text
.global main
.extern printf
.extern scanf

@ ---------------------------------------
@ mulFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	r5.	
mulFunc:
push {ip, lr}
mul	r5, r1, r3
pop	{ip, pc}

@ ---------------------------------------
@ sumFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	r5.	
sumFunc:
push {ip, lr}
add	r5, r1, r3
pop	{ip, pc}

main:   
push 	{ip, lr}	@ push return address + dummy register 

@ READ NUMBERS

ldr	r0, =func_prompt
bl	printf

ldr	r0, =xprompt
bl	printf

ldr r0, =format	@ call scanf, and pass address of format
ldr	r1, =x	@ string and address of a in r0, and r1,
bl	scanf		@ respectively.

@ PERFORM FUNCTION

ldr	r1, =x		@ get address of a into r1
ldr	r1, [r1]	@ get a into r1
mov r3,	r1		@ COPY VALUE TO PERFORM X^2
bl 	mulFunc		@ X^2
mov	r1, r5
mov r3, #6
bl 	mulFunc		@ 6x^2
mov r2, r5

ldr	r1, =x		@ get address of a into r1
ldr	r1, [r1]	@ get a into r1
mov r3, #9
bl 	mulFunc		@ 9x

mov	r3, r5
mov r1, r2
bl	sumFunc		@ 6x^2 + 9x

mov r3, r5
mov r1, #2
bl	sumFunc		@ 6x^2 + 9x + 2

@ PRINT RESULT
mov r1, r5
ldr	r0, =result_prompt
bl	printf

pop 	{ip, pc}	@ pop return address into pc

