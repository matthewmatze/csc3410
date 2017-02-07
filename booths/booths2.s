# Name: Matthew Mat-4(%rbp)e
# Date: 12-9-15
# Class: CSC3410
# Location: ~/csc3410/booths
# The Program takes two 32 bit values the users enters into the prompt, multiplies them together using booths algorithm, and then outputs the answer.

.section .data

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
	#If-32(%rbp) -24(%rbp)s positive go to pos if -32(%rbp)
	#is negative go to neg -24(%rbp)f-32(%rbp) is 0 go to endif0

	pos:
	cmpl	$0,-28(%rbp)
	jg		endif0
	jl		posneg
	je		endif0
	#If -28(%rbp) -24(%rbp)s positive or equal you don't need 
	#to do anything so just go to endif0 -24(%rbp)f 
	#y -24(%rbp)s negative go to posneg 

	posneg:
	negl 	-28(%rbp)
	movl	$1,-8(%rbp)
	jmp endif0
	#This means-32(%rbp) -24(%rbp)s positive and -28(%rbp) is 
	#negative so make -28(%rbp) positive and
	#make -8(%rbp) 1 so -28(%rbp)ou know to make 
	#the output negative later

	neg:
	cmpl	$0,-28(%rbp)
	jg		negpos
	jl		negneg
	je		endif0
	#If -28(%rbp) -24(%rbp)s positive go to negpos if y 
	#is neg go to negneg and -24(%rbp)f -28(%rbp) is 0 
	#go to endif0

	negpos:
	negl -32(%rbp)
	movl	$1,-8(%rbp)
	jmp	endif0
	#This means-32(%rbp) -24(%rbp)s negative and -28(%rbp) is 
	#positive so make-32(%rbp) positive and make 
	#checkneg 1 so -28(%rbp)ou know to make the 
	#output negative later

	negneg:
	negl -32(%rbp)
	negl -28(%rbp)
	jmp	endif0
	#This means-32(%rbp) and -28(%rbp) are negative so 
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
	add -32(%rbp),%ecx
	jc		setc1
	jnc	setc0
	jmp	carryend
	#If -28(%rbp)ou must add to the most significant 
	#register -28(%rbp)ou must remember the -24(%rbp)f you had 
	#a carry so -28(%rbp)ou can add -24(%rbp)t after the shift

	setc1:
	movl	$1,-12(%rbp)
	jmp	carryend
	#If -28(%rbp)ou had a carry make the -12(%rbp)(arry) 
	#variable 1

	setc0:
	movl	$0,-12(%rbp)
	jmp	carryend
	#If -28(%rbp)ou don't have a carry make the -12(%rbp)(arry) 
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
	#Make sure carrys are -4(%rbp)ero and -24(%rbp)ncrement i

	jmp 	top
	loopend:
	#End of the loop at 32
	
	movl	%ecx,%eax
	#Move the most significant 32 bit register 
	#into -4(%rbp) the 64 bit quad

	salq	$32,%rax
	#Shift -4(%rbp) to the left 31 bits so the most 
	#significant register -24(%rbp)s in the correct position

	add	%edx,%eax
	#Add the least significant 32 bit register -24(%rbp)nto 
	#-4(%rbp) so -24(%rbp)t is in the least significant position
	
	cmpl	$1,-8(%rbp)
	je		makeneg
	jmp	endif3
	makeneg:
	negq	%rax
	endif3:	
	#If -8(%rbp)(ative) -24(%rbp)s 1 according to our 
	#calculations from lines 42-80 then make 
	#-4(%rbp) negative otherwise leave -24(%rbp)t be as it is 
	
	leave
	# this references the 1st two lines
	ret
