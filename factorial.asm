# Factorial.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
# Joseph Yue

# Assembly (NON-RECURSIVE) version of:
#   int n, fn=1;
#   cout << "Enter a number:\n";
#   cin >> n;
#   for (int x = 2; x <= n; x++) {
#       fn = fn * x;
#   }
#   cout << "Factorial of " << x << " is:\n" << fn << "\n";
#
.data
	input: .asciiz "Enter a number:\n"
	output1: .asciiz "Factorial of "
	output2: .asciiz " is:\n"
	newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text
main:
	#This block prints all the text that comes before the numerical output
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 4
	la $a0, output1
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, output2
	syscall

	li $a0, 1

loop:
	beq $t0, $zero, loop_exit
	mult $a0, $t0
	mflo $a0
	addi $t0, -1
	j loop

loop_exit:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

exit:
	li $v0, 10
	syscall
