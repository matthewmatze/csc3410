# Name:        R. Shore        
# Date:        Nov 20, 2015
# Class: CSC-3410
# Program sets up a small array to demonstrate how
#   1) Use a function
#   2) Access an array using an address
#   3) perform a binary search
#   4) Output the results in the main function
#
         .equ        true,1
         .equ        false,0
.data
infmt:   .string        "%d"
outfmt1: .string        "found\n"
outfmt2: .string        "not\n"
outfmt3: .string        "%d\n"

#-------------------------------
# I know variables are usually upside down in C/C++ 
# but I'm writing my own, 
# reserve 4 bytes, something about allignment.
# ALSO - looks like C/C++ aligns on 16 byte chunks
#
#  -48(%rbp) to -12(%rbp) array x 
#  -8(%rbp) sv  - not initialized
#  -4(%rbp) f  - not initialized - really only need 1 byte but
#   
.text
.globl  main
.type   main,@function

main:
        pushq  %rbp
        movq   %rsp,%rbp

        subq   $48,%rsp        #reserve space for 12 ints
        movl   $4,-48(%rbp)    # establish an array 
        movl   $6,-44(%rbp)  
        movl   $14,-40(%rbp)  
        movl   $17,-36(%rbp)  
        movl   $25,-32(%rbp)  
        movl   $29,-28(%rbp)  
        movl   $32,-24(%rbp)  
        movl   $34,-20(%rbp)  
        movl   $43,-16(%rbp)  
        movl   $50,-12(%rbp)  

        movl   $0,%eax         # scanf("%d",&n);
        movq   $infmt,%rdi
        leaq   -8(%rbp),%rsi
        call    scanf

                               # call binSearch
        leaq   -48(%rbp),%rdi  # this one is a 64-bit addr
        movl   $0,%esi         # int l
        movl   $9,%edx         # int r
        movl   -8(%rbp),%ecx   # int sv
        call   binSearch
        movb   %al,-1(%rbp)    # store return value as bool

        cmpb   $0,-1(%rbp)     # if(found)
        je     not
        movl   $0,%eax
        movq   $outfmt1,%rdi
        call   printf          #    found it
        jmp    main_done
not:
        movl   $0,%eax
        movq   $outfmt2,%rdi
        call   printf
main_done:
        movl   $0,%eax
        leave
        ret
#-------------------------------
# seach the array for the sv.  if present, return true otherwise false
#  
#  -24(%rbp) address of array
#  -16(%rbp) reserved for l
#  -12(%rbp) reserved for r
#  -8(%rbp) reserved for sv
#  -4(%rbp) reserved for m
#-------------------------------
.text
.globl  binSearch
.type   binSearch,@function

binSearch:
        pushq  %rbp
        movq   %rsp,%rbp

        subq   $24,%rsp        # reserves space for params
                               # and locals
        movq   %rdi,-24(%rbp)  # x[]
        movl   %esi,-16(%rbp)  # l 
        movl   %edx,-12(%rbp)  # r 
        movl   %ecx,-8(%rbp)   # sv 

        movl   -12(%rbp),%eax  # if(l <= r)
        cmpl   -16(%rbp),%eax
        jl     bs_not

        movl   -12(%rbp),%eax  #    m=(l+r)/2;
        addl   -16(%rbp),%eax
        #Next line is OK to div by 2 unless it's negative
        #if that is a possibility then do the following
        #Shift right 31 to get sign bit in the 1st bit
        #add in that bit 
        #then shift arithmetic 1 bit to the right
        sarl   $1,%eax
        movl   %eax,-4(%rbp)

        movq   $0,%rax         #      if(sv == x[m])
        movl   -4(%rbp),%eax
        movq   -24(%rbp),%rdi
        movl   (%rdi,%rax,4),%edx
        cmpl   -8(%rbp),%edx
        jne    nxt1
        movb   $true,%al       #          reutrn true
        jmp    bs_exit
nxt1:                          #same cmpl just jump
        jl     nxt2            #      else if (sv < x[m])
        movq   -24(%rbp),%rdi  #            array addr
        movl   -16(%rbp),%esi  #            l
        movl   -4(%rbp),%edx   #             m-1
        decl   %edx
        movl   -8(%rbp),%ecx   #          sv
        call    binSearch      #           recurse  binSearch
        #jump to exit, al already has return value        
        jmp    bs_exit
nxt2:                          #      else ===> (sv > x[m])
        movq   -24(%rbp),%rdi  #          array addr
        movl   -4(%rbp),%esi   #          m+1
        incl   %esi
        movl   -12(%rbp),%edx  #          r
        movl   -8(%rbp),%ecx   #          sv
        call   binSearch
        #jump to exit, al already has return value        
        jmp    bs_exit
bs_not:
        movb   $false,%al      # binSearch did not find the value
                               # return false;
bs_exit:
        leave
        ret
