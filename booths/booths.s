# Name: Matthew Matze
# Date: 10-14-15
# Class: CSC3410
# Location: ~/csc3410/booths
# The Program takes two 32 bit values the users enters into the prompt, multplies them together using booths algorithm, and then outputs the answer.

#The input from the users are located in -32 and -28

# -32(%rbp)=x
# -28(%rbp)=y
# -24(%rbp)=i
# -20(%rbp)=cx
# -16(%rbp)=cy
# -12(%rbp)=leftc
# -8(%rbp)=checkneg

.data
.text
.globl	booths
.type booths,@function
booths:
	pushq	%rbp
	movq	%rsp,%rbp

	subq $32,%rsp	
	movq %rsi,-32(%rbp)
	movq %rdi,-28(%rbp)


	cmpl	$0,-32(%rbp)
	jg		pos
	jl		neg
	je		endif0
	#If x is positive go to pos if x 
	#is negative go to neg if x is 0 go to endif0

	pos:
	cmpl	$0,-28(%rbp)
	jg		endif0
	jl		posneg
	je		endif0
	#If y is positive or equal you don't need 
	#to do anything so just go to endif0 if 
	#y is negative go to posneg 

	posneg:
	negl 	-28(%rbp)
	movl	$1,-8(%rbp)
	jmp endif0
	#This means x is positive and y is 
	#negative so make y positive and
	#make checkneg 1 so you know to make 
	#the output negative later

	neg:
	cmpl	$0,-28(%rbp)
	jg		negpos
	jl		negneg
	je		endif0
	#If y is positive go to negpos if y 
	#is neg go to negneg and if y is 0 
	#go to endif0

	negpos:
	negl	-32(%rbp)
	movl	$1,-8(%rbp)
	jmp	endif0
	#This means x is negative and y is 
	#positive so make x positive and make 
	#checkneg 1 so you know to make the 
	#output negative later

	negneg:
	negl -32(%rbp)
	negl -28(%rbp)
	jmp	endif0
	#This means x and y are negative so 
	#make them both positive and continue 
	#business as usual

	endif0:
	
	movl 	$0,%ecx
	movl	$0,%edx
	movl	-28(%rbp),%edx
	#Zero the registers I am using and 
	#set the multiplicand to the least 
	#significant register

	top:
	cmpl	$31,-24(%rbp)
	jge	loopend
	#Beginning of the loop from 0 to 31

	movl	%edx,-16(%rbp)
	andl	$1,-16(%rbp)
	#Set the least significant register's 
	#least significant carry flag	
	
	cmp	$1,-16(%rbp)
	je		addx
	jmp	endif
	#If the carry of the least significant 
	#register will be 1 then add the multiplier 
	#otherwise continue business as usual

	addx:
	add	-32(%rbp),%ecx
	jc		setc1
	jnc	setc0
	jmp	carryend
	#If you must add to the most significant 
	#register you must remember the if you had 
	#a carry so you can add it after the shift

	setc1:
	movl	$1,-12(%rbp)
	jmp	carryend
	#If you had a carry make the leftc(arry) 
	#variable 1

	setc0:
	movl	$0,-12(%rbp)
	jmp	carryend
	#If you don't have a carry make the leftc(arry) 
	#variable 0

	carryend:

	endif:
		
	movl	%ecx,-20(%rbp)
	andl	$1,-20(%rbp)
	#Set the most significant register's least 
	#significant carry flag
		
	sarl	$1,%ecx	
	sarl	$1,%edx
	#Shift both the registers one to the right	

	cmp	$1,-20(%rbp)
	je		addy
	jmp	endif1
	addy:
	addl	$1073741824 ,%edx
	endif1:
	#If a 1 would be shifted right from the most 
	#significant register to the least then add 
	#a 1 to the most significant end of the least 
	#significant register
		
	cmp	$1,-12(%rbp)
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
	incl 	-24(%rbp)
	movl	$0,-20(%rbp)	
	movl	$0,-16(%rbp)	
	#Make sure carrys are zero and increment i

	jmp 	top
	loopend:
	#End of the loop at 32
	
	movl	%ecx,%r8d
	#Move the most significant 32 bit register 
	#into z the 64 bit quad

	salq	$32,%r8
	#Shift z to the left 31 bits so the most 
	#significant register is in the correct position

	addl	%r8d,%r8d
	#Add the least significant 32 bit register into 
	#z so it is in the least significant position
	
	cmpl	$1,-8(%rbp)
	je		makeneg
	jmp	endif3
	makeneg:
	negq	%r8
	endif3:	
	#If checkneg(ative) is 1 according to our 
	#calculations from lines 42-80 then make 
	#z negative otherwise leave it be as it is 

	movq %r8,%rax

	leave
	# this references the 1st two lines
	ret
