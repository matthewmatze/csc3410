	.text
	.globl	gcd
	.type	gcd, @function
gcd:
	pushq	%rbp
	movq	%rsp, %rbp
	movl %esi,%ecx
	movl %edi,%ebx
loop:
	cmp $0,%edx
	je endif
	movl %ecx ,%eax
	cqto
	idiv %ebx
	movl %ebx,%ecx
	movl %edx,%ebx
	call loop
endif:
	movl %ecx,%eax
	leave
	ret
