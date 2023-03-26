	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"add.c"
	.text
	.align	1
	.global	add
	.syntax unified
	.thumb
	.thumb_func
	.type	add, %function
add:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r2, [r7, #4]
	ldr	r3, [r7]
	add	r3, r3, r2
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	add, .-add
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	movs	r3, #1
	str	r3, [r7, #4]
	movs	r3, #2
	str	r3, [r7, #8]
	ldr	r1, [r7, #8]
	ldr	r0, [r7, #4]
	bl	add(PLT)
	vmov	s15, r0	@ int
	vcvt.f64.s32	d7, s15
	vldr.64	d6, .L5
	vmul.f64	d7, d7, d6
	vcvt.f32.f64	s15, d7
	vstr.32	s15, [r7, #12]
	vldr.32	s15, [r7, #12]
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L6:
	.align	3
.L5:
	.word	1374389535
	.word	1074339512
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-17ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",%progbits
