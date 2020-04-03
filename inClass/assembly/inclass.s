@ ---------------------------------------
@       Code Section
@ ---------------------------------------
.text
.global main

main:
    MOV r0,#0x1000
	ADD r1,r2,#0xFF0000
	MOV r0,#0xFFFFFFFF
	LDR r0,=0xFF
	LDR r0,=0x55555555
    BX lr
