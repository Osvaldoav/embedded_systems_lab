@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
.data
.balign 4	
prompt_operand_1:	.asciz	"Give me the first operand: "
prompt_operation:	.asciz	"Give me the operation to be performed (+, -, *, /): "
prompt_operand_2:	.asciz	"Give me the second operand: "
result_prompt_1:	.asciz	"The result of %d %c %d is: "
result_prompt_2:	.asciz	"%d\n"
format_operand: 	.asciz 	"%d"
format_operation: 	.asciz	" %c"

a:		.word	0
b:		.word	0
oper:	.word	0
res: 	.word 	0
suma: 	.word   0x2B
resta: 	.word   0x2D
multi: 	.word   0x2A
divi: 	.word   0x2F
	
@ ---------------------------------------
@	Code Section
@ ---------------------------------------
	
.text
.global main
.extern printf
.extern scanf

@ ---------------------------------------
@ sumFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	r5.	
sumFunc:
push {ip, lr}
add	r5, r1, r3
pop	{ip, pc}

@ ---------------------------------------
@ restaFunc: gets 2 ints in r1 and r3, substract
@ 	them and saves the results in
@	r5.	
restaFunc:
push {ip, lr}
sub	r5, r1, r3
pop	{ip, pc}

@ ---------------------------------------
@ mulFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	r5.	
mulFunc:
push {ip, lr}
mul	r5, r1, r3
pop	{ip, pc}

@ ---------------------------------------
@ divFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	r5.	
divFunc:
push {ip, lr}
sdiv r5, r1, r3
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

ldr r0, =result_prompt_1	@ print the result prompt
ldr	r1, =a					@ get address of a into r1
ldr	r1, [r1]				@ get a into r1
ldr	r2, =oper				@ get address of oper into r2
ldr	r2, [r2]				@ get oper into r2
ldr	r3, =b					@ get address of b into r3
ldr	r3, [r3]				@ get b into r3

ldr r4, =suma				@ get address of suma into r4
ldr r4, [r4]				@ get suma into r4
cmp r2, r4					@ compare r2 with r4
bleq sumFunc				@ if equal, then jump to sumFunc.

ldr r4, =resta				@ get address of resta into r4
ldr r4, [r4]				@ get resta into r4
cmp r2, r4					@ compare r2 with r4
bleq restaFunc				@ if equal, then jump to restaFunc.

ldr r4, =multi				@ get address of multi into r4
ldr r4, [r4]				@ get multi into r4
cmp r2, r4					@ compare r2 with r4
bleq mulFunc				@ if equal, then jump to mulFunc.

ldr r4, =divi				@ get address of divi into r4
ldr r4, [r4]				@ get divi into r4
cmp r2, r4					@ compare r2 with r4
bleq divFunc				@ if equal, then jump to divFunc.

bl printf					@ print the first part of the answer.

ldr r0, =result_prompt_2	@ print the final result
mov r1, r5					@ load the result which is stored in r5

bl printf					@ print the final answer.


pop	{ip, pc}				@ pop return address into pc
