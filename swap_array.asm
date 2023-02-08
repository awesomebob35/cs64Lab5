# swap_array.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
# Joseph Yue
#
# IMPORTANT: READ, BUT DO NOT CHANGE ANY OF THE CODE IN THIS PROGRAM
#           THAT IS ALREADY THERE! ONLY ADD YOUR NEW CODE WHERE 
#           IT SAYS TO DO SO, i.e. IN THE doSwap: AREA.
#

.data
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        

incorrect:  .asciiz "---TEST FAILED---\n"
before:     .asciiz "Before:\n"
after:      .asciiz "After:\n"
comma:      .asciiz ", "
newline:    .asciiz "\n"
        
expectedMyArray:
        .word 29 28 27 26 25 24 23 22 21 20 19
myArray:
        .word 19 20 21 22 23 24 25 26 27 28 29

.text
# Print everything in the array (without use of a loop)
# Used as a function/sub-routine

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
		li $v0, 1
        lw $a0, 36($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 40($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
# unsigned int* p1 = expectedMyArray
# unsigned int* p2 = myArray
# unsigned int* limit = expectedMyArray + 11
#
# while (p1 < limit) {
#   if (*p1 != *p2) {
#     return 0                  
#   }
#   p1++                        
#   p2++
# }
# return 1                      

checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 44

checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        # Print array "before"
        la $a0, before
        li $v0, 4
        syscall

        jal printArray
        
        # Do swap function 
        jal doSwap

        # Print array "after"
        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        # Perform check on array
        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
	li $v0, 10
        syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS
        # assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 0
        # unsigned int y = 10
        #
        # while (x != 5) {
        #   int temp = myArray[x]
        #   myArray[x] = myArray[y]
        #   myArray[y] = temp
        #   x++
        #   y--
        # }

        li $t0, 0
        li $t1, 10
        li $t2, 5

loop:
        beq $t0, $t2 loop_exit
        
        la $t3, myArray
        li $a0, 4
        mult $t0, $a0
        mflo $a1
        addu $t4, $t3, $a1
        mult $t1, $a0
        mflo $a2
        addu $t5, $t3, $a2

        lw $t6, 0($t4)
        lw $t7, 0($t5)
        sw $t7, 0($t4)
        sw $t6, 0($t5)

        addi $t0, 1
        addi $t1, -1

        j loop

loop_exit:
        # do not remove this last line
        jr $ra
