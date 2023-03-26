	.arch armv7-a
	.fpu vfpv3-d16	@不知道为啥，反正得加这句
	@ .eabi_attribute 28, 1
	@ .eabi_attribute 20, 1
	@ .eabi_attribute 21, 1
	@ .eabi_attribute 23, 3
	@ .eabi_attribute 24, 1
	@ .eabi_attribute 25, 1
	@ .eabi_attribute 26, 2
	@ .eabi_attribute 30, 6
	@ .eabi_attribute 34, 1
	@ .eabi_attribute 18, 4
	.file	"add.c"	@这一段为伪指令，声明一些信息
	.text
	.align	1
	.global	add	@声明全局函数
	@ .syntax unified
	@ .thumb
	@ .thumb_func
	.type	add, %function	@声明add类型：函数
add:
	push	{r7}	@保存状态
	sub	sp, sp, #12	@开辟12字节栈帧
	add	r7, sp, #0	@r7为临时变量，r7=sp
	str	r0, [r7, #4]	@参数1入栈
	str	r1, [r7]		@参数2入栈
	ldr	r2, [r7, #4]	@加载参数1和2
	ldr	r3, [r7]
	add	r3, r3, r2	@相加
	mov	r0, r3		@结果存到r0
	adds	r7, r7, #12	@sp复位
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4	@pop保存的r7
	bx	lr			@返回地址
	.size	add, .-add
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%f\012\000"
	.text
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
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	ldr	r1, .L5+8
.LPIC0:
	add	r1, pc
	mov	r0, r1
	bl	printf(PLT)
	movs	r3, #0
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
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-17ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",%progbits
