#Name: 
#Date: 
#Class: csc-3410
#Location: 
#
#This program prompts the user for two integers, x and y, and performs
#the necessary steps to implement Booth's Algorithm for multiplication
#of 32-bit signed integers and outputs a 64-bit signed number

.section .data
prompt:  .string "Please enter two integers: "
outfmt:  .string "x = %d and y = %d\n"
outfmt2: .string "z = %ld\n"
infmt:   .string "%d%d"
x:       .long   0
y:       .long   0
z:       .quad   0
mplier:  .long   0
mcand:   .long   0
cnt:     .long   0
mask:    .long   3

.text
.globl main
.type main, @function
main:
        pushq %rbp
        movq  %rsp, %rbp

        movq  $0, %rax
        movq  $prompt, %rdi
        call  printf         #printf("Please enter two integers: ")

        movq  $0, %rax
        movq  $infmt, %rdi
        movl  $x, %esi
        movl  $y, %edx
        call  scanf          #scanf("%ld%ld\n")

        movl  $0, %eax
        movl  x, %eax
        movl  %eax, mplier   #makes x the multiplier
        movl  $0, %edx
        movl  y, %edx
        movl  %edx, mcand    #makes y the multiplicand
        movl  $0, %ebx       #ebx is the first 32-bits
        movl  $0, %ecx       #ecx is the last 32-bits


        andl  $1, %eax       #masks the least significant bit of eax
                             #first case when starting Booth's Algo.

        cmpl  $1, %eax       #if(eax == binary 1) 
        jne   endif
then:
        subl  mcand, %ebx    #subtracts first 32-bits by mulitplicand
        sarl $1, %ebx        #sign shifts first 32 bits right by 1
        rcrl $1, %ecx        #takes the 1 bit that fell off from ebx
                             #rotates it into most significant bit of
                             #ecx as it shifts right by 1 also
endif:
        incl cnt             #increment counter
        movl mplier, %eax    #put original multiplier back into eax
        andl mask, %eax      #mask the two least significant bits of eax
                             #so it holds multiplier bit and next lower-
                             #order bit

loopbegin:                   #loop to continue remaining 31 steps of Booth's
        cmpl $32, cnt        #if(cnt >= 32) stop loop
        jge  loopend
        cmpl $2, %eax        #if(eax == binary 10) sub then shift
        je   then3
        cmpl $1, %eax        #if(eax == binary 01) add then shift 
        je   then4
        jmp  endif2          #else do nothing just shift 
then3:
        subl mcand, %ebx     #subtracts multiplicand
        jmp  endif2
then4:       
        addl mcand, %ebx     #adds multiplicand
        jmp  endif2
endif2:
        sarl $1, %ebx        #sign shifts first 32-bits right by 1
        rcrl $1, %ecx        #rotates ebx's fallen off bit into eax's
                             #most signif. bit as it shifts right by 1
        shrl $1, mplier      #shifts multiplier to the right by 1
        movl mplier, %eax    #put multiplier into %eax
        andl mask, %eax      #masks the least two signif. bits of eax so
                             #it holds new mulitplier bit and next low bit

        incl cnt             #increment counter
        jmp  loopbegin       #jump back to the beginning of loop

loopend:
        movq $0, %rax
        movl %ebx, %eax        
        shlq $32, %rax        #shift eax into the first 32 bits of rax
        movl %ecx, %edx       #puts last 32 bits into last 32 bits of rdx
        addq %rdx, %rax       #puts rdx into last 32 bits of rax
        movq %rax, z

        movq $0, %rax
        movq $outfmt, %rdi
        movl x, %esi
        movl y, %edx
        call printf           #printf(x = %d and y = %d\n")

        movq $0, %rax
        movq $outfmt2, %rdi
        movq z, %rsi
        call printf           #printf("z = "%ld\n")

        movl  $0, %eax        #return 0
        leave
        ret
