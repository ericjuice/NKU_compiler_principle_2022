	.arch armv7-a
	.fpu vfpv3-d16	@不知道为啥，反正得加这句
	.file	"add.c"	@这一段为伪指令，声明一些信息
	.text
	.align	1
	.global	add	@声明全局函数
	.syntax unified
	.thumb
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
main:
	push	{r7, lr}	@返回地址和r7入栈，之后lr会给pc
	sub	sp, sp, #16		@开辟栈帧
	add	r7, sp, #0		@同add的操作，r7=sp
	movs	r3, #1		@局部变量a,b入栈
	str	r3, [r7, #4]
	movs	r3, #2
	str	r3, [r7, #8]	
	ldr	r1, [r7, #8]	@加载形参
	ldr	r0, [r7, #4]
	bl	add			@调用函数
	@下面在进行浮点数的转化，没太看懂，先抄一段
	vmov	s15, r0	@ vmov是扩展的指令，add返回值扩展为float存到s15
	vcvt.f64.s32	d7, s15	@float转双精度double，存在d7
	vldr.64	d6, .Label	@加载label的两个word到d6
	vmul.f64	d7, d7, d6	@相乘
	vcvt.f32.f64	s15, d7	@转化回单精度float
	vstr.32	s15, [r7, #12]	@存取这个返回值
	vldr.32	s15, [r7, #12]
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7	@扩展移动d7
	ldr	r1, .Label+8

.L0:
	add	r1, r1, pc
	mov	r0, r1
	bl	printf
	movs	r3, #0	@return 0
	mov	r0, r3
	adds	r7, r7, #16	@栈帧恢复
	mov	sp, r7
	pop	{r7, pc}	@r7恢复,pc恢复
.str:
	.ascii	"%f\n\0"	@存储静态字符串
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb	@切换到thumb指令集
	.type	main, %function
.Label:
	.word	1374389535	@存储浮点数相关信息
	.word	1074339512
	.word	.str-(.L0+4)	@存储地址
