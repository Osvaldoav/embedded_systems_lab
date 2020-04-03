@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
.data
.balign 4	
prompt_operand_1:	.asciz	"Give me the first operand:\n"
prompt_operation:	.asciz	"Give me the operation to be performed (+, -, *, /):\n"
prompt_operand_2:	.asciz	"Give me the second operand:\n"
result_prompt:		.asciz	"The result of %d %c %d is: %d \n"
format_operand: 	.asciz 	"%d"
format_operation: 	.asciz	"%c"

a:		.word	0
b:		.word	0
oper:	.word	0
res: 	.word 	0
suma: 	.word  0x2A
resta: 	.word 0x2D
multi: 	.word 0x2A
divi: 	.word 0x2F
	
@ ---------------------------------------
@	Code Section
@ ---------------------------------------
	
.text
.global main
.extern printf
.extern scanf

@ ---------------------------------------
@ sumFunc: gets 2 ints in r1 and r2, adds
@ 	them up and saves the results in
@	r0.	
sumFunc:
push {ip, lr}
add	r0, r1, r2
pop	{ip, pc}

main:   
push {ip, lr}	@ push return address + dummy register
				@ for alignment

@ READ NUMBERS

ldr	r0, =prompt_operand_1	@ print the prompt operand 1
bl	printf

ldr r0, =format_operand		@ call scanf, and pass address of format
ldr	r1, =a					@ string and address of a in r0, and r1,
bl	scanf					@ respectively.

ldr	r0, =prompt_operation	@ print the prompt operation
bl	printf

ldr r0, =format_operation	@ call scanf, and pass address of format
ldr	r1, =oper				@ string and address of b in r0, and r1,
bl	scanf					@ respectively.

ldr	r0, =prompt_operand_2	@ print the prompt operand 2
bl	printf

ldr r0, =format_operand		@ call scanf, and pass address of format
ldr	r1, =b					@ string and address of b in r0, and r1,
bl	scanf					@ respectively.

@ ADD NUMBERS

ldr	r1, =a					@ get address of a into r1
ldr	r1, [r1]				@ get a into r1
ldr	r2, =b					@ get address of b into r2
ldr	r2, [r2]				@ get b into r2


@ PRINT NUMBERS

ldr	r1, =a					@ print num formatted by output string.
ldr	r1, [r1]
ldr	r2, =b					@ print num formatted by output string.
ldr	r2, [r2]
ldr	r3, =res				@ print num formatted by output string.
ldr	r3, [r3]
ldr	r0, =result_prompt
bl	printf


pop	{ip, pc}				@ pop return address into pc
