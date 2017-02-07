# Name:Matthew Matze
# Date:9-22-15
# Class:csc3410
# Location: ~/csc3410/assembly2
# The Program takes the two values the users enters into the prompt and stores them as x and y respectively, executes the equation z=(3*x*x)-(26*y)+(x*y/3), and outputs z.
.data
prompt:	.string	"Please enter the x and y variables to be calculated: \n"
informat:.string	"%ld"
outmsg1:	.string	"x=%ld\n"
outmsg2:	.string	"y=%ld\n"
outmsg3:	.string	"z=%ld\n"
x:			.quad		0
y:			.quad		0
z:			.quad		0
.text
.globl	main
.type main,@function
main:
	pushq	%rbp
	movq	%rsp,%rbp
	movq	$prompt,%rdi
	call	printf
	#printf("Please enter the x and y variables to be calculated: \n");

	movq 	$0,%rax
	movq 	$informat,%rdi
	movq	$x,%rsi
	call scanf
	#scanf("%ld",&x);
	
	movq 	$0,%rax
	movq 	$informat,%rdi
	movq	$y,%rsi
	call scanf
	#scanf("%ld",&y);

	movq 	$0,%rax
	movq	x,%rdi
	imulq	x,%rdi
	imulq	$3,%rdi
	movq	y,%rsi
	imulq	$26,%rsi
	movq	x,%rdx
	imulq	y,%rdx
	movq	%rdx,%rax	
	movq	$3,%rbx
	cqto
	idivq	%rbx
	subq %rsi,%rdi
	addq %rdi,%rax
	movq %rax,z
	#z=(3*x*x)-(26*y)+(x*y/3)

	movq 	$0,%rax
	movq 	$outmsg1,%rdi
	movq 	x,%rsi
	call	printf
	#printf("x=%ld\n",x);
	
	movq 	$0,%rax
	movq 	$outmsg2,%rdi
	movq 	y,%rsi
	call	printf
	#printf("y=%ld\n",y);

	movq 	$0,%rax
	movq 	$outmsg3,%rdi
	movq 	z,%rsi
	call	printf
	#printf("z=%ld\n",z);
	
	leave
	# this references the 1st two lines
	ret
