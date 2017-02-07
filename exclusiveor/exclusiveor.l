GAS LISTING /tmp/ccDorpi1.s 			page 1


   1              		.file	"exclusiveor.c"
   2              		.text
   3              	.Ltext0:
   4              		.section	.rodata
   5              		.align 8
   6              	.LC0:
   7 0000 506C6561 		.string	"Please type in the x and y variable we should switch with a white space in between: "
   7      73652074 
   7      79706520 
   7      696E2074 
   7      68652078 
   8              	.LC1:
   9 0055 25630A00 		.string	"%c\n"
  10              	.LC2:
  11 0059 256300   		.string	"%c"
  12              	.LC3:
  13 005c 78206973 		.string	"x is now %c y is now %c\n"
  13      206E6F77 
  13      20256320 
  13      79206973 
  13      206E6F77 
  14              		.text
  15              		.globl	main
  17              	main:
  18              	.LFB0:
  19              		.file 1 "exclusiveor.c"
   1:exclusiveor.c **** /*
   2:exclusiveor.c ****       Name: Matthew Matze
   3:exclusiveor.c ****       Date: 9/8/2015
   4:exclusiveor.c ****       Class: csc3410
   5:exclusiveor.c ****       Location:~/csc3410/exclusiveor.c
   6:exclusiveor.c **** */
   7:exclusiveor.c **** 
   8:exclusiveor.c **** #include<stdio.h>
   9:exclusiveor.c **** 
  10:exclusiveor.c **** int main(void)
  11:exclusiveor.c **** {
  20              		.loc 1 11 0
  21              		.cfi_startproc
  22 0000 55       		pushq	%rbp
  23              		.cfi_def_cfa_offset 16
  24              		.cfi_offset 6, -16
  25 0001 4889E5   		movq	%rsp, %rbp
  26              		.cfi_def_cfa_register 6
  27 0004 4883EC10 		subq	$16, %rsp
  12:exclusiveor.c **** 	char x,y;
  13:exclusiveor.c **** 	
  14:exclusiveor.c **** 	printf("Please type in the x and y variable we should switch with a white space in between: ");
  28              		.loc 1 14 0
  29 0008 BF000000 		movl	$.LC0, %edi
  29      00
  30 000d B8000000 		movl	$0, %eax
  30      00
  31 0012 E8000000 		call	printf
  31      00
  15:exclusiveor.c **** 	scanf("%c\n",&x);
  32              		.loc 1 15 0
GAS LISTING /tmp/ccDorpi1.s 			page 2


  33 0017 488D45FF 		leaq	-1(%rbp), %rax
  34 001b 4889C6   		movq	%rax, %rsi
  35 001e BF000000 		movl	$.LC1, %edi
  35      00
  36 0023 B8000000 		movl	$0, %eax
  36      00
  37 0028 E8000000 		call	__isoc99_scanf
  37      00
  16:exclusiveor.c **** 	scanf("%c",&y);
  38              		.loc 1 16 0
  39 002d 488D45FE 		leaq	-2(%rbp), %rax
  40 0031 4889C6   		movq	%rax, %rsi
  41 0034 BF000000 		movl	$.LC2, %edi
  41      00
  42 0039 B8000000 		movl	$0, %eax
  42      00
  43 003e E8000000 		call	__isoc99_scanf
  43      00
  17:exclusiveor.c **** 	x=x^y;
  44              		.loc 1 17 0
  45 0043 0FB655FF 		movzbl	-1(%rbp), %edx
  46 0047 0FB645FE 		movzbl	-2(%rbp), %eax
  47 004b 31D0     		xorl	%edx, %eax
  48 004d 8845FF   		movb	%al, -1(%rbp)
  18:exclusiveor.c **** 	y=x^y;
  49              		.loc 1 18 0
  50 0050 0FB655FF 		movzbl	-1(%rbp), %edx
  51 0054 0FB645FE 		movzbl	-2(%rbp), %eax
  52 0058 31D0     		xorl	%edx, %eax
  53 005a 8845FE   		movb	%al, -2(%rbp)
  19:exclusiveor.c **** 	x=x^y;
  54              		.loc 1 19 0
  55 005d 0FB655FF 		movzbl	-1(%rbp), %edx
  56 0061 0FB645FE 		movzbl	-2(%rbp), %eax
  57 0065 31D0     		xorl	%edx, %eax
  58 0067 8845FF   		movb	%al, -1(%rbp)
  20:exclusiveor.c **** 	printf("x is now %c y is now %c\n",x, y);
  59              		.loc 1 20 0
  60 006a 0FB645FE 		movzbl	-2(%rbp), %eax
  61 006e 0FBED0   		movsbl	%al, %edx
  62 0071 0FB645FF 		movzbl	-1(%rbp), %eax
  63 0075 0FBEC0   		movsbl	%al, %eax
  64 0078 89C6     		movl	%eax, %esi
  65 007a BF000000 		movl	$.LC3, %edi
  65      00
  66 007f B8000000 		movl	$0, %eax
  66      00
  67 0084 E8000000 		call	printf
  67      00
  21:exclusiveor.c **** 
  22:exclusiveor.c ****    return 0;
  68              		.loc 1 22 0
  69 0089 B8000000 		movl	$0, %eax
  69      00
  23:exclusiveor.c **** }
  70              		.loc 1 23 0
  71 008e C9       		leave
GAS LISTING /tmp/ccDorpi1.s 			page 3


  72              		.cfi_def_cfa 7, 8
  73 008f C3       		ret
  74              		.cfi_endproc
  75              	.LFE0:
  77              	.Letext0:
GAS LISTING /tmp/ccDorpi1.s 			page 4


DEFINED SYMBOLS
                            *ABS*:0000000000000000 exclusiveor.c
     /tmp/ccDorpi1.s:17     .text:0000000000000000 main

UNDEFINED SYMBOLS
printf
__isoc99_scanf
