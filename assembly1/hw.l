GAS LISTING hw.s 			page 1


   1              	# Name:Matthew Matze
   2              	# Date:9-20-15
   3              	# Class:csc3410
   4              	# Location: ~/csc3410/assembly1
   5              	.data
   6 0000 48656C6C 	outfont:	.string	"Hello World\n"
   6      6F20576F 
   6      726C640A 
   6      00
   7              	.text
   8              	.globl	main
  10              	main:
  11 0000 55       		pushq	%rbp
  12 0001 4889E5   		movq	%rsp,%rbp
  13 0004 48C7C700 		movq	$outfont,%rdi
  13      000000
  14 000b E8000000 		call	printf
  14      00
  15 0010 B8000000 		movl	$0,%eax
  15      00
  16 0015 C9       		leave
  17              		# this references the 1st two lines
  18 0016 C3       		ret
GAS LISTING hw.s 			page 2


DEFINED SYMBOLS
                hw.s:6      .data:0000000000000000 outfont
                hw.s:10     .text:0000000000000000 main

UNDEFINED SYMBOLS
printf
