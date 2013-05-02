	.file	"sdcard.S"

__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__ = 0x34

__tmp_reg__ = 0
__zero_reg__ = 1

	.section	.text.__vector_15,"ax",@progbits
.global	__vector_15
	.type	__vector_15, @function
__vector_15:
.LFB125:
.LSM134:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
.LSM135:
	lds r22,206
.LVL34:
.LSM136:
#	lds r24,USB_DeviceState
#	cpi r24,lo8(4)
#	brne .L27
.LSM137:
#	ldi r24,lo8(USARTtoUSB_Buffer)
#	ldi r25,hi8(USARTtoUSB_Buffer)
#	call RingBuffer_Insert
.LVL35:
.L27:
/* epilogue start */
.LSM138:
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
.LFE125:
	.size	__vector_15, .-__vector_15
