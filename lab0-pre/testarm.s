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
	.file	"perf_t.c"
	.text
	.section	.rodata
	.align	2
.LC1:
	.ascii	"start at %d times\000"
	.align	2
.LC2:
	.ascii	"loop 1\000"
	.align	2
.LC3:
	.ascii	"test n= %d,\012time:%f ms\012\000"
	.align	2
.LC0:
	.word	100
	.word	500
	.word	1000
	.word	5000
	.word	10000
	.word	50000
	.word	100000
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #72
	add	r7, sp, #0
	ldr	r2, .L10
.LPIC4:
	add	r2, pc
	ldr	r3, .L10+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [r7, #68]
	mov	r3, #0
	ldr	r3, .L10+8
.LPIC0:
	add	r3, pc
	add	r4, r7, #40
	mov	r5, r3
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldm	r5, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	movs	r3, #0
	str	r3, [r7, #4]
	b	.L2
.L7:
	mov	r3, sp
	mov	r4, r3
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	mov	r1, r3
	ldr	r3, .L10+12
.LPIC1:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	ldr	r3, [r7, #4]
	lsls	r3, r3, #2
	adds	r3, r3, #72
	add	r3, r3, r7
	ldr	r1, [r3, #-32]
	subs	r3, r1, #1
	str	r3, [r7, #16]
	mov	r2, r1
	movs	r3, #0
	mov	r8, r2
	mov	r9, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r9, #5
	orr	r3, r3, r8, lsr #27
	lsl	r2, r8, #5
	mov	r2, r1
	movs	r3, #0
	mov	r10, r2
	mov	fp, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, fp, #5
	orr	r3, r3, r10, lsr #27
	lsl	r2, r10, #5
	mov	r3, r1
	lsls	r3, r3, #2
	adds	r3, r3, #7
	lsrs	r3, r3, #3
	lsls	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	adds	r3, r3, #3
	lsrs	r3, r3, #2
	lsls	r3, r3, #2
	str	r3, [r7, #20]
	movs	r3, #0
	str	r3, [r7, #8]
	b	.L3
.L4:
	ldr	r3, [r7, #8]
	movs	r2, #10
	mul	r1, r2, r3
	ldr	r3, [r7, #20]
	ldr	r2, [r7, #8]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [r7, #8]
	adds	r3, r3, #1
	str	r3, [r7, #8]
.L3:
	ldr	r3, [r7, #4]
	lsls	r3, r3, #2
	adds	r3, r3, #72
	add	r3, r3, r7
	ldr	r3, [r3, #-32]
	ldr	r2, [r7, #8]
	cmp	r2, r3
	blt	.L4
	bl	clock(PLT)
	str	r0, [r7, #24]
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L5
.L6:
	ldr	r3, [r7, #20]
	ldr	r2, [r7, #12]
	ldr	r3, [r3, r2, lsl #2]
	mov	r2, #2000
	mul	r1, r2, r3
	ldr	r3, [r7, #20]
	ldr	r2, [r7, #12]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [r7, #20]
	ldr	r2, [r7, #12]
	ldr	r2, [r3, r2, lsl #2]
	movw	r3, #35757
	movt	r3, 26843
	smull	r1, r3, r3, r2
	asrs	r1, r3, #12
	asrs	r3, r2, #31
	subs	r1, r1, r3
	ldr	r3, [r7, #20]
	ldr	r2, [r7, #12]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L5:
	ldr	r3, [r7, #4]
	lsls	r3, r3, #2
	adds	r3, r3, #72
	add	r3, r3, r7
	ldr	r3, [r3, #-32]
	ldr	r2, [r7, #12]
	cmp	r2, r3
	blt	.L6
	ldr	r3, .L10+16
.LPIC2:
	add	r3, pc
	mov	r0, r3
	bl	puts(PLT)
	bl	clock(PLT)
	str	r0, [r7, #28]
	ldr	r2, [r7, #28]
	ldr	r3, [r7, #24]
	subs	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d7, s15
	vstr.64	d7, [r7, #32]
	ldr	r3, [r7, #4]
	lsls	r3, r3, #2
	adds	r3, r3, #72
	add	r3, r3, r7
	ldr	r1, [r3, #-32]
	ldrd	r2, [r7, #32]
	ldr	r0, .L10+20
.LPIC3:
	add	r0, pc
	bl	printf(PLT)
	mov	sp, r4
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L2:
	ldr	r3, [r7, #4]
	cmp	r3, #6
	ble	.L7
	movs	r3, #0
	ldr	r1, .L10+24
.LPIC5:
	add	r1, pc
	ldr	r2, .L10+4
	ldr	r2, [r1, r2]
	ldr	r1, [r2]
	ldr	r2, [r7, #68]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L9
	bl	__stack_chk_fail(PLT)
.L9:
	mov	r0, r3
	adds	r7, r7, #72
	mov	sp, r7
	@ sp needed
	pop	{r4, r5, r7, r8, r9, r10, fp, pc}
.L11:
	.align	2
.L10:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC4+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-17ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",%progbits
