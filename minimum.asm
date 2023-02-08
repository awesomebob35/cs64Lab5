# minimum.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
# Joseph Yue

.data
	input: .asciiz "Enter the next number:\n"
	output: .asciiz "Minimum: "
    newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text

main:
	#These 3 blocks are for taking three numbers as input
	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	la $a0, newline
	li $v0, 4

	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	la $a0, newline
	li $v0, 4

	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	la $a0, newline
	li $v0, 4

	#Print the word minimum
	li $v0, 4
	la $a0, output
	syscall

	blt $t1, $t0, t1_smaller_than_t0

	blt $t2, $t0, t2_smaller_than_t0

	move $a0, $t0
	j print_output

t1_smaller_than_t0:
	blt $t2, $t1, t2_smaller_than_t1

	move $a0, $t1
	j print_output

t2_smaller_than_t0:
	move $a0, $t2
	j print_output

t2_smaller_than_t1:
	move $a0, $t2
	j print_output

print_output:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

exit:
	li $v0, 10
	syscall
