# Name:Matthew Matze
# Date:9-20-15
# Class:csc3410
# Location: ~/csc3410/assembly1
.data
outfont:	.string	"Hello World\n"
.text
.globl	main
.type main,@function
main:
	pushq	%rbp
	movq	%rsp,%rbp
	movq	$outfont,%rdi
	call	printf
	movl	$0,%eax
	leave
	# this references the 1st two lines
	ret
