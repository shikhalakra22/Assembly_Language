.data
input:    .asciiz "Enter the number whose factorial to find: "
output:   .asciiz "The factorial is: "
number:   .word 0
result:   .word 0

.text
   .globl main
    main:

		li $v0, 4
		la $a0, input
		syscall

		li $v0, 5
		syscall

		sw $v0, number
		lw $a0, number
		jal factorial
		sw $v0, result


		li $v0, 4
		la $a0, output
		syscall

		li $v0, 1
		lw $a0, result
		syscall

		li $v0, 10
		syscall

   .globl factorial
    factorial:
		subu $sp, $sp, 8
		sw $ra, ($sp)
		sw $s0, 4($sp)

		li $v0, 1
	    beq $a0, $zero, last

		move $s0, $a0
		sub $a0, $a0, 1
		jal factorial

		mul $v0, $v0, $s0


	last:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8
		jr $ra




