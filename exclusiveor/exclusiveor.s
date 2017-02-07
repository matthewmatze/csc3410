	.file	"exclusiveor.c"
	.section	.rodata
	.align 8
.LC0:
//The print statement asking to enter variables
	.string	"Please type in the x and y variable we should switch with a white space in between: "
.LC1:
//The first letter's scanf
	.string	"%c\n"
.LC2:
//The second letter's scanf
	.string	"%c"
.LC3:
//The last print statement displaying your results
	.string	"x is now %c y is now %c\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	leaq	-1(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	leaq	-2(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movzbl	-1(%rbp), %edx
	movzbl	-2(%rbp), %eax
	xorl	%edx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %edx
	movzbl	-2(%rbp), %eax
	xorl	%edx, %eax
	movb	%al, -2(%rbp)
	movzbl	-1(%rbp), %edx
	movzbl	-2(%rbp), %eax
	xorl	%edx, %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 5.1.1 20150618 (Red Hat 5.1.1-4)"
	.section	.note.GNU-stack,"",@progbits
