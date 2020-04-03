@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
	.data
	.balign 4	
prompt_operand_1:	.asciz	"Give me the first operand:\n"
prompt_operand_2:	.asciz	"Give me the second operand:\n"
result_prompt:	.asciz	"The result of %d + %d is: %d \n"
format: .asciz 	"%d"

a:		.word	0
b:		.word	0
res: 	.word 	0
	
@ ---------------------------------------
@	Code Section
@ ---------------------------------------
	
	.text
	.global main
	.extern printf
	.extern scanf

main:   push 	{ip, lr}	@ push return address + dummy register
							@ for alignment

	@ READ NUMBERS

	ldr	r0, =prompt_operand_1	@ print the prompt operand 1
	bl	printf

	ldr r0, =format	@ call scanf, and pass address of format
	ldr	r1, =a	@ string and address of a in r0, and r1,
	bl	scanf		@ respectively.

	ldr	r0, =prompt_operand_2	@ print the prompt operand 2
	bl	printf

	ldr r0, =format	@ call scanf, and pass address of format
	ldr	r1, =b	@ string and address of b in r0, and r1,
	bl	scanf		@ respectively.

	@ ADD NUMBERS

	ldr	r1, =a		@ get address of a into r1
	ldr	r1, [r1]	@ get a into r1
	ldr	r2, =b		@ get address of b into r2
	ldr	r2, [r2]	@ get b into r2
	add	r1, r1, r2	@ add r1 to r2 and store into r1
	ldr	r2, =res	@ get address of c into r2
	str	r1, [r2]	@ store r1 into c

	@ PRINT NUMBERS

	ldr	r1, =a	@ print num formatted by output string.
	ldr	r1, [r1]
	ldr	r2, =b	@ print num formatted by output string.
	ldr	r2, [r2]
	ldr	r3, =res	@ print num formatted by output string.
	ldr	r3, [r3]
	ldr	r0, =result_prompt
	bl	printf


    pop 	{ip, pc}	@ pop return address into pc
