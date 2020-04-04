@ ---------------------------------------
@	Data Section
@ ---------------------------------------
	
.data
.balign 4	
prompt_operand_1:	.asciz	"Give me the first operand: "
prompt_operation:	.asciz	"Give me the operation to be performed (+, -, *, /): "
prompt_operand_2:	.asciz	"Give me the second operand: "
prompt_operand_3:	.asciz	"Give me the third operand: "
result_prompt_1:	.asciz	"The result of %d %c %d"
result_prompt_2:    .asciz  " %c %d is: %d\n"
format_operand: 	.asciz 	"%d"
format_operation: 	.asciz	" %c"

a:		.word	0
b:		.word	0
c:      .word   0
oper_1:	.word	0
oper_2:	.word	0
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
@	res.	
sumFunc:
push {ip, lr}
add	r5, r1, r3
ldr r6, =res
str r5, [r6]
pop	{ip, pc}

@ ---------------------------------------
@ restaFunc: gets 2 ints in r1 and r3, substract
@ 	them and saves the results in
@	res.	
restaFunc:
push {ip, lr}
sub	r5, r1, r3
ldr r6, =res
str r5, [r6]
pop	{ip, pc}

@ ---------------------------------------
@ mulFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	res.	
mulFunc:
push {ip, lr}
mul	r5, r1, r3
ldr r6, =res
str r5, [r6]
pop	{ip, pc}

@ ---------------------------------------
@ divFunc: gets 2 ints in r1 and r3, adds
@ 	them up and saves the results in
@	res.	
divFunc:
push {ip, lr}
sdiv r5, r1, r3
ldr r6, =res
str r5, [r6]
pop	{ip, pc}

@ ---------------------------------------
@ operFunc: gets 2 ints in r1 and r3, 
@           gets 1 operation in r2,
@           decides on the operation and saves the
@           result in res.
operFunc:
push {ip, lr}
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
pop	{ip, pc}

@ ---------------------------------------
@ firstPairFirstFunc: 
@           Operates on the first two numbers first, 
@           and then on the second pair.
@           the result is stored on res
firstPairFirstFunc:
push {ip, lr}
ldr	r1, =a					@ get address of a into r1
ldr	r1, [r1]				@ get a into r1
ldr	r2, =oper_1				@ get address of oper_1 into r2
ldr	r2, [r2]				@ get oper_1 into r2
ldr	r3, =b					@ get address of b into r3
ldr	r3, [r3]				@ get b into r3

bl operFunc

@ Same, but now res [operation] c
ldr r1, =res
ldr r1, [r1]
ldr r2, =oper_2
ldr r2, [r2]
ldr r3, =c
ldr r3, [r3]

bl operFunc
pop	{ip, pc}

@ ---------------------------------------
@ secondPairFirstFunc: 
@           Operates on the second pair of numbers first, 
@           and then on the first pair.
@           the result is stored on res
secondPairFirstFunc:
push {ip, lr}
ldr	r1, =b					@ get address of b into r1
ldr	r1, [r1]				@ get b into r1
ldr	r2, =oper_2				@ get address of oper_2 into r2
ldr	r2, [r2]				@ get oper_2 into r2
ldr	r3, =c					@ get address of c into r3
ldr	r3, [r3]				@ get c into r3

bl operFunc

@ Same, but now res [operation] c
ldr r1, =a
ldr r1, [r1]
ldr r2, =oper_1
ldr r2, [r2]
ldr r3, =res
ldr r3, [r3]

bl operFunc
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
ldr	r1, =oper_1				@ string and address of oper_1 in r0, and r1,
bl	scanf					@ respectively.

ldr	r0, =prompt_operand_2	@ print the prompt operand 2
bl	printf

ldr r0, =format_operand		@ call scanf, and pass address of format
ldr	r1, =b					@ string and address of b in r0, and r1,
bl	scanf					@ respectively.

ldr	r0, =prompt_operation	@ print the prompt operation
bl	printf

ldr r0, =format_operation	@ call scanf, and pass address of format
ldr	r1, =oper_2				@ string and address of oper_2 in r0, and r1,
bl	scanf					@ respectively.

ldr	r0, =prompt_operand_2	@ print the prompt operand 2
bl	printf

ldr r0, =format_operand		@ call scanf, and pass address of format
ldr	r1, =c					@ string and address of c in r0, and r1,
bl	scanf					@ respectively.

@ OPERATE ON THE NUMBERS


@ If the first operand is equal to * or /, then we do that one first.
@ else (meaning that the first operand is + or -) we do the second one first.
ldr	r2, =oper_1				@ get address of oper_1 into r2
ldr	r2, [r2]				@ get oper_1 into r2
ldr	r3, =multi				@ get address of multi into r3
ldr	r3, [r3]				@ get multi into r3
cmp r2, #0x2A
@ldr	r3, =divi				@ get address of divi into r3
@ldr	r3, [r3]				@ get divi into r3
cmpne r2, #0x2F
mrs r0, cpsr
bleq firstPairFirstFunc
msr cpsr, r0
blne secondPairFirstFunc





ldr r0, =result_prompt_1	@ print the result prompt
ldr r1, =a
ldr r1, [r1]
ldr r2, =oper_1
ldr r2, [r2]
ldr r3, =b
ldr r3, [r3]
bl printf					@ print the first part of the answer.

ldr r0, =result_prompt_2	@ print the final result
ldr r1, =oper_2
ldr r1, [r1]
ldr r2, =c
ldr r2, [r2]
ldr r3, =res
ldr r3, [r3]

bl printf					@ print the final answer.


pop	{ip, pc}				@ pop return address into pc
