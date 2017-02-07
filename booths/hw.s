# Name: Matthew Matze
# Date: 10-14-15
# Class: CSC3410
# Location: ~/csc3410/booths
# The Program takes two 32 bit values the users enters into the prompt, multplies them together using booths algorithm, and then outputs the answer.

.data
prompt:  .string  "Please enter two 32 bit values to be multiplied: \n"
informat:.string  "%d"
outmsg1: .string  "The multiplier was %d\n"
outmsg2: .string  "The multiplicand was %d\n"
outmsg3: .string  "The answer is %ld\n"
i:			.long		0
x:			.long		0
y:			.long		0
cx:		.long		0
cy:		.long		0
leftc:	.long		0
checkneg:.long		0
z:			.quad		0

.text
.globl	main
.type main,@function
main:
	pushq	%rbp
	movq	%rsp,%rbp
	movq	$prompt,%rdi
	call	printf
	#printf("Please enter the x and y variables to be multiplied: \n");

	movl 	$0,%eax
	movl 	$informat,%edi
	movl	$x,%esi
	call scanf
	#scanf("%d",&x);
	
	movl 	$0,%eax
	movl 	$informat,%edi
	movl	$y,%esi
	call	scanf
	#scanf("%d",&y);

	cmpl	$0,x
	jg		pos
	jl		neg
	je		endif0
	#If x is positive go to pos if x 
	#is negative go to neg if x is 0 go to endif0

	pos:
	cmpl	$0,y
	jg		endif0
	jl		posneg
	je		endif0
	#If y is positive or equal you don't need 
	#to do anything so just go to endif0 if 
	#y is negative go to posneg 

	posneg:
	negl 	y
	movl	$1,checkneg
	jmp endif0
	#This means x is positive and y is 
	#negative so make y positive and
	#make checkneg 1 so you know to make 
	#the output negative later

	neg:
	cmpl	$0,y
	jg		negpos
	jl		negneg
	je		endif0
	#If y is positive go to negpos if y 
	#is neg go to negneg and if y is 0 
	#go to endif0

	negpos:
	negl	x
	movl	$1,checkneg
	jmp	endif0
	#This means x is negative and y is 
	#positive so make x positive and make 
	#checkneg 1 so you know to make the 
	#output negative later

	negneg:
	negl x
	negl y
	jmp	endif0
	#This means x and y are negative so 
	#make them both positive and continue 
	#business as usual

	endif0:
	
	movl 	$0,%ecx
	movl	$0,%edx
	movl	y,%edx
	#Zero the registers I am using and 
	#set the multiplicand to the least 
	#significant register

	top:
	cmpl	$31,i
	jge	loopend
	#Beginning of the loop from 0 to 31

	movl	%edx,cy
	andl	$1,cy
	#Set the least significant register's 
	#least significant carry flag	
	
	cmp	$1,cy
	je		addx
	jmp	endif
	#If the carry of the least significant 
	#register will be 1 then add the multiplier 
	#otherwise continue business as usual

	addx:
	add	x,%ecx
	jc		setc1
	jnc	setc0
	jmp	carryend
	#If you must add to the most significant 
	#register you must remember the if you had 
	#a carry so you can add it after the shift

	setc1:
	movl	$1,leftc
	jmp	carryend
	#If you had a carry make the leftc(arry) 
	#variable 1

	setc0:
	movl	$0,leftc
	jmp	carryend
	#If you don't have a carry make the leftc(arry) 
	#variable 0

	carryend:

	endif:
		
	movl	%ecx,cx
	andl	$1,cx
	#Set the most significant register's least 
	#significant carry flag
		
	sarl	$1,%ecx	
	sarl	$1,%edx
	#Shift both the registers one to the right	

	cmp	$1,cx
	je		addy
	jmp	endif1
	addy:
	addl	$1073741824 ,%edx
	endif1:
	#If a 1 would be shifted right from the most 
	#significant register to the least then add 
	#a 1 to the most significant end of the least 
	#significant register
		
	cmp	$1,leftc
	je		addc
	jmp	endif2
	addc:
	addl	$1073741824 ,%ecx
	endif2:
	#If the left carry flag of the most significant 
	#register was 1 when we added then add 1 to the 
	#most significant end of the most significant 
	#register for the carry flag's 1

	#End of the loop from 0 to 31
	incl 	i
	movl	$0,cx	
	movl	$0,cy	
	#Make sure carrys are zero and increment i

	jmp 	top
	loopend:
	#End of the loop at 32
	
	movl	%ecx,z
	#Move the most significant 32 bit register 
	#into z the 64 bit quad

	salq	$32,z
	#Shift z to the left 31 bits so the most 
	#significant register is in the correct position

	add	%edx,z
	#Add the least significant 32 bit register into 
	#z so it is in the least significant position
	
	cmpl	$1,checkneg
	je		makeneg
	jmp	endif3
	makeneg:
	negq	z
	endif3:	
	#If checkneg(ative) is 1 according to our 
	#calculations from lines 42-80 then make 
	#z negative otherwise leave it be as it is 

	movl 	$0,%eax
	movl 	$outmsg1,%edi
	movl 	x,%esi
	call	printf
	#printf("The multiplier was %d\n");

	movl 	$0,%eax
	movl 	$outmsg2,%edi
	movl 	y,%esi
	call	printf
	#printf("The multiplicand was %d\n");

	movq 	$0,%rax
	movq 	$outmsg3,%rdi
	movq 	z,%rsi
	call	printf
	#printf("The answer is %ld\n");

	leave
	# this references the 1st two lines
	ret
