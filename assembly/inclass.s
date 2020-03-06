	.data
a: 	.word	0xAABBCCD

	.text
	.global main

main:
	LDR r0, =a
	BX lr
