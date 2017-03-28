%include "io.mac"

.DATA
.CODE
	.STARTUP
	mov EAX, -3C7Fh
	mov ECX, 32
ciclo:
	cmp ECX,0
	je fin
	shl EAX,1
	jc bit_1
bit_0:
	PutCh '0'
	dec ECX
	jmp ciclo
bit_1:
	PutCh '1'
	dec ECX
	jmp ciclo
fin:
	.EXIT
