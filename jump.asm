.data
string_y: .asciiz "y="
newline: .asciiz "\n"

.text

main:
	li $a0, 5
	jal function
	move $s0, $v0
	j print_statement

function:
	li $t1, 3
	mul $t0, $t1, $a0
	addi $v0, $t0, 5
	jr $ra

print_statement:
	li $v0, 4
	la $a0, string_y
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, newline
	syscall