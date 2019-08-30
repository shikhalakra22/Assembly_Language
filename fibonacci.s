.data
input:   .asciiz "Enter the number whose fibonacci to find out: "       #print labels
output:  .asciiz "The fibonacci of given number is: "
number:  .word 0														#labels to store input and output
result:  .word 0

.text
main:
	li $v0, 4
	la $a0, input								#print the "input" string
	syscall

	li $v0, 5
	syscall										#taking the user input

 	sw $v0, number						
 	lw $a0, number								#move the input value to a0
 	jal fibonacci								#calling the fibonacci function
 	sw $v0, result


	li $v0, 4
	la $a0, output								#print the "output label"
	syscall

	li $v0, 1
	lw $a0, result							   #prints the value returned by the function
	syscall

	li $v0, 10									#exits the program
	syscall

fibonacci:
	subu $sp, $sp, 12							#decreasing the stack for 3 registers
	sw $ra, 8($sp)
	sw $s0, 4($sp) 							    #pushing the registers
	sw $s1, ($sp)
    move $s0, $a0								#moving value of f(n-1) to another register

	li $v0, 1
    ble $s0, 3, last							#base condition (if n < 3) jump to last label
	sub $a0, $s0, 1								

	jal fibonacci								#jumping again to fibonacci 
	move $s1, $v0
	sub $a0, $s0, 2								

	jal fibonacci								#jumping again to fibonacci
	add $v0, $v0, $s1 							# f(n-1) + f(n-2)

last:
	lw $ra, 8($sp)								
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addu $sp, $sp, 12					    	#incrementing the stack 
	jr $ra										#return to main funtion

	
