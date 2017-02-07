GAS LISTING binaryS.s 			page 1


   1              	# Name:        R. Shore        
   2              	# Date:        Nov 20, 2015
   3              	# Class: CSC-3410
   4              	# Program sets up a small array to demonstrate how
   5              	#   1) Use a function
   6              	#   2) Access an array using an address
   7              	#   3) perform a binary search
   8              	#   4) Output the results in the main function
   9              	#
  10              	         .equ        true,1
  11              	         .equ        false,0
  12              	.data
  13 0000 256400   	infmt:   .string        "%d"
  14 0003 666F756E 	outfmt1: .string        "found\n"
  14      640A00
  15 000a 6E6F740A 	outfmt2: .string        "not\n"
  15      00
  16 000f 25640A00 	outfmt3: .string        "%d\n"
  17              	
  18              	#-------------------------------
  19              	# I know variables are usually upside down in C/C++ 
  20              	# but I'm writing my own, 
  21              	# reserve 4 bytes, something about allignment.
  22              	# ALSO - looks like C/C++ aligns on 16 byte chunks
  23              	#
  24              	#  -48(%rbp) to -12(%rbp) array x 
  25              	#  -8(%rbp) sv  - not initialized
  26              	#  -4(%rbp) f  - not initialized - really only need 1 byte but
  27              	#   
  28              	.text
  29              	.globl  main
  31              	
  32              	main:
  33 0000 55       	        pushq  %rbp
  34 0001 4889E5   	        movq   %rsp,%rbp
  35              	
  36 0004 4883EC30 	        subq   $48,%rsp        #reserve space for 12 ints
  37 0008 C745D004 	        movl   $4,-48(%rbp)    # establish an array 
  37      000000
  38 000f C745D406 	        movl   $6,-44(%rbp)  
  38      000000
  39 0016 C745D80E 	        movl   $14,-40(%rbp)  
  39      000000
  40 001d C745DC11 	        movl   $17,-36(%rbp)  
  40      000000
  41 0024 C745E019 	        movl   $25,-32(%rbp)  
  41      000000
  42 002b C745E41D 	        movl   $29,-28(%rbp)  
  42      000000
  43 0032 C745E820 	        movl   $32,-24(%rbp)  
  43      000000
  44 0039 C745EC22 	        movl   $34,-20(%rbp)  
  44      000000
  45 0040 C745F02B 	        movl   $43,-16(%rbp)  
  45      000000
  46 0047 C745F432 	        movl   $50,-12(%rbp)  
  46      000000
GAS LISTING binaryS.s 			page 2


  47              	
  48 004e B8000000 	        movl   $0,%eax         # scanf("%d",&n);
  48      00
  49 0053 48C7C700 	        movq   $infmt,%rdi
  49      000000
  50 005a 488D75F8 	        leaq   -8(%rbp),%rsi
  51 005e E8000000 	        call    scanf
  51      00
  52              	
  53              	                               # call binSearch
  54 0063 488D7DD0 	        leaq   -48(%rbp),%rdi  # this one is a 64-bit addr
  55 0067 BE000000 	        movl   $0,%esi         # int l
  55      00
  56 006c BA090000 	        movl   $9,%edx         # int r
  56      00
  57 0071 8B4DF8   	        movl   -8(%rbp),%ecx   # int sv
  58 0074 E8000000 	        call   binSearch
  58      00
  59 0079 8845FF   	        movb   %al,-1(%rbp)    # store return value as bool
  60              	
  61 007c 807DFF00 	        cmpb   $0,-1(%rbp)     # if(found)
  62 0080 7413     	        je     not
  63 0082 B8000000 	        movl   $0,%eax
  63      00
  64 0087 48C7C700 	        movq   $outfmt1,%rdi
  64      000000
  65 008e E8000000 	        call   printf          #    found it
  65      00
  66 0093 EB11     	        jmp    main_done
  67              	not:
  68 0095 B8000000 	        movl   $0,%eax
  68      00
  69 009a 48C7C700 	        movq   $outfmt2,%rdi
  69      000000
  70 00a1 E8000000 	        call   printf
  70      00
  71              	main_done:
  72 00a6 B8000000 	        movl   $0,%eax
  72      00
  73 00ab C9       	        leave
  74 00ac C3       	        ret
  75              	#-------------------------------
  76              	# seach the array for the sv.  if present, return true otherwise false
  77              	#  
  78              	#  -24(%rbp) address of array
  79              	#  -16(%rbp) reserved for l
  80              	#  -12(%rbp) reserved for r
  81              	#  -8(%rbp) reserved for sv
  82              	#  -4(%rbp) reserved for m
  83              	#-------------------------------
  84              	.text
  85              	.globl  binSearch
  87              	
  88              	binSearch:
  89 00ad 55       	        pushq  %rbp
  90 00ae 4889E5   	        movq   %rsp,%rbp
  91              	
GAS LISTING binaryS.s 			page 3


  92 00b1 4883EC18 	        subq   $24,%rsp        # reserves space for params
  93              	                               # and locals
  94 00b5 48897DE8 	        movq   %rdi,-24(%rbp)  # x[]
  95 00b9 8975F0   	        movl   %esi,-16(%rbp)  # l 
  96 00bc 8955F4   	        movl   %edx,-12(%rbp)  # r 
  97 00bf 894DF8   	        movl   %ecx,-8(%rbp)   # sv 
  98              	
  99 00c2 8B45F4   	        movl   -12(%rbp),%eax  # if(l <= r)
 100 00c5 3B45F0   	        cmpl   -16(%rbp),%eax
 101 00c8 7C53     	        jl     bs_not
 102              	
 103 00ca 8B45F4   	        movl   -12(%rbp),%eax  #    m=(l+r)/2;
 104 00cd 0345F0   	        addl   -16(%rbp),%eax
 105              	        #Next line is OK to div by 2 unless it's negative
 106              	        #if that is a possibility then do the following
 107              	        #Shift right 31 to get sign bit in the 1st bit
 108              	        #add in that bit 
 109              	        #then shift arithmetic 1 bit to the right
 110 00d0 D1F8     	        sarl   $1,%eax
 111 00d2 8945FC   	        movl   %eax,-4(%rbp)
 112              	
 113 00d5 48C7C000 	        movq   $0,%rax         #      if(sv == x[m])
 113      000000
 114 00dc 8B45FC   	        movl   -4(%rbp),%eax
 115 00df 488B7DE8 	        movq   -24(%rbp),%rdi
 116 00e3 8B1487   	        movl   (%rdi,%rax,4),%edx
 117 00e6 3B55F8   	        cmpl   -8(%rbp),%edx
 118 00e9 7504     	        jne    nxt1
 119 00eb B001     	        movb   $true,%al       #          reutrn true
 120 00ed EB30     	        jmp    bs_exit
 121              	nxt1:                          #same cmpl just jump
 122 00ef 7C16     	        jl     nxt2            #      else if (sv < x[m])
 123 00f1 488B7DE8 	        movq   -24(%rbp),%rdi  #            array addr
 124 00f5 8B75F0   	        movl   -16(%rbp),%esi  #            l
 125 00f8 8B55FC   	        movl   -4(%rbp),%edx   #             m-1
 126 00fb FFCA     	        decl   %edx
 127 00fd 8B4DF8   	        movl   -8(%rbp),%ecx   #          sv
 128 0100 E8000000 	        call    binSearch      #           recurse  binSearch
 128      00
 129              	        #jump to exit, al already has return value        
 130 0105 EB18     	        jmp    bs_exit
 131              	nxt2:                          #      else ===> (sv > x[m])
 132 0107 488B7DE8 	        movq   -24(%rbp),%rdi  #          array addr
 133 010b 8B75FC   	        movl   -4(%rbp),%esi   #          m+1
 134 010e FFC6     	        incl   %esi
 135 0110 8B55F4   	        movl   -12(%rbp),%edx  #          r
 136 0113 8B4DF8   	        movl   -8(%rbp),%ecx   #          sv
 137 0116 E8000000 	        call   binSearch
 137      00
 138              	        #jump to exit, al already has return value        
 139 011b EB02     	        jmp    bs_exit
 140              	bs_not:
 141 011d B000     	        movb   $false,%al      # binSearch did not find the value
 142              	                               # return false;
 143              	bs_exit:
 144 011f C9       	        leave
 145 0120 C3       	        ret
GAS LISTING binaryS.s 			page 4


GAS LISTING binaryS.s 			page 5


DEFINED SYMBOLS
           binaryS.s:10     *ABS*:0000000000000001 true
           binaryS.s:11     *ABS*:0000000000000000 false
           binaryS.s:13     .data:0000000000000000 infmt
           binaryS.s:14     .data:0000000000000003 outfmt1
           binaryS.s:15     .data:000000000000000a outfmt2
           binaryS.s:16     .data:000000000000000f outfmt3
           binaryS.s:32     .text:0000000000000000 main
           binaryS.s:88     .text:00000000000000ad binSearch
           binaryS.s:67     .text:0000000000000095 not
           binaryS.s:71     .text:00000000000000a6 main_done
           binaryS.s:140    .text:000000000000011d bs_not
           binaryS.s:121    .text:00000000000000ef nxt1
           binaryS.s:143    .text:000000000000011f bs_exit
           binaryS.s:131    .text:0000000000000107 nxt2

UNDEFINED SYMBOLS
scanf
printf
