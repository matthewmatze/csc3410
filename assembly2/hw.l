GAS LISTING hw.s 			page 1


   1              	# Name:Matthew Matze
   2              	# Date:9-22-15
   3              	# Class:csc3410
   4              	# Location: ~/csc3410/assembly2
   5              	.data
   6 0000 506C6561 	prompt:	.string	"Please enter the x and y variables to be calculated: \n"
   6      73652065 
   6      6E746572 
   6      20746865 
   6      20782061 
   7 0037 256C6400 	informat:.string	"%ld"
   8 003b 783D256C 	outmsg1:	.string	"x=%ld\n"
   8      640A00
   9 0042 793D256C 	outmsg2:	.string	"y=%ld\n"
   9      640A00
  10 0049 7A3D256C 	outmsg3:	.string	"z=%ld\n"
  10      640A00
  11 0050 00000000 	x:			.quad		0
  11      00000000 
  12 0058 00000000 	y:			.quad		0
  12      00000000 
  13 0060 00000000 	z:			.quad		0
  13      00000000 
  14              	.text
  15              	.globl	main
  17              	main:
  18 0000 55       		pushq	%rbp
  19 0001 4889E5   		movq	%rsp,%rbp
  20 0004 48C7C700 		movq	$prompt,%rdi
  20      000000
  21 000b E8000000 		call	printf
  21      00
  22              		#printf("Please enter the x and y variables to be calculated: \n");
  23              	
  24 0010 48C7C000 		movq 	$0,%rax
  24      000000
  25 0017 48C7C700 		movq 	$informat,%rdi
  25      000000
  26 001e 48C7C600 		movq	$x,%rsi
  26      000000
  27 0025 E8000000 		call scanf
  27      00
  28              		#scanf("%ld",&x);
  29              		
  30 002a 48C7C000 		movq 	$0,%rax
  30      000000
  31 0031 48C7C700 		movq 	$informat,%rdi
  31      000000
  32 0038 48C7C600 		movq	$y,%rsi
  32      000000
  33 003f E8000000 		call scanf
  33      00
  34              		#scanf("%ld",&y);
  35              	
  36 0044 48C7C000 		movq 	$0,%rax
  36      000000
  37 004b 488B3C25 		movq	x,%rdi
GAS LISTING hw.s 			page 2


  37      00000000 
  38 0053 480FAF3C 		imulq	x,%rdi
  38      25000000 
  38      00
  39 005c 486BFF03 		imulq	$3,%rdi
  40 0060 488B3425 		movq	y,%rsi
  40      00000000 
  41 0068 486BF61A 		imulq	$26,%rsi
  42 006c 488B1425 		movq	x,%rdx
  42      00000000 
  43 0074 480FAF14 		imulq	y,%rdx
  43      25000000 
  43      00
  44 007d 4889D0   		movq	%rdx,%rax	
  45 0080 48C7C303 		movq	$3,%rbx
  45      000000
  46 0087 4899     		cqto
  47 0089 48F7FB   		idivq	%rbx
  48              	
  49 008c 4829F7   		subq %rsi,%rdi
  50 008f 4801F8   		addq %rdi,%rax
  51 0092 48890425 		movq %rax,z
  51      00000000 
  52              		#z=(3*x*x)-(26*y)+(x*y/3)
  53              	
  54 009a 48C7C000 		movq 	$0,%rax
  54      000000
  55 00a1 48C7C700 		movq 	$outmsg1,%rdi
  55      000000
  56 00a8 488B3425 		movq 	x,%rsi
  56      00000000 
  57 00b0 E8000000 		call	printf
  57      00
  58              		#printf("x=%ld\n",x);
  59              		
  60 00b5 48C7C000 		movq 	$0,%rax
  60      000000
  61 00bc 48C7C700 		movq 	$outmsg2,%rdi
  61      000000
  62 00c3 488B3425 		movq 	y,%rsi
  62      00000000 
  63 00cb E8000000 		call	printf
  63      00
  64              		#printf("y=%ld\n",y);
  65              	
  66 00d0 48C7C000 		movq 	$0,%rax
  66      000000
  67 00d7 48C7C700 		movq 	$outmsg3,%rdi
  67      000000
  68 00de 488B3425 		movq 	z,%rsi
  68      00000000 
  69 00e6 E8000000 		call	printf
  69      00
  70              		#printf("z=%ld\n",z);
  71              		
  72 00eb C9       		leave
  73              		# this references the 1st two lines
GAS LISTING hw.s 			page 3


  74 00ec C3       		ret
GAS LISTING hw.s 			page 4


DEFINED SYMBOLS
                hw.s:6      .data:0000000000000000 prompt
                hw.s:7      .data:0000000000000037 informat
                hw.s:8      .data:000000000000003b outmsg1
                hw.s:9      .data:0000000000000042 outmsg2
                hw.s:10     .data:0000000000000049 outmsg3
                hw.s:11     .data:0000000000000050 x
                hw.s:12     .data:0000000000000058 y
                hw.s:13     .data:0000000000000060 z
                hw.s:17     .text:0000000000000000 main

UNDEFINED SYMBOLS
printf
scanf
