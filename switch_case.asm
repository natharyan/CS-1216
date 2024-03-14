.data
prompt: .asciiz "Enter a numerical input value: "
string_i: .asciiz "\nValue of i:\n"
string_A: .asciiz "\nValues of A:\n"
newline: .asciiz "\n"
array: .word -2, -2

.text
main:
    # Print the prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the input value from the user
    li $v0, 5
    syscall

    # Save the input value in $t0
    move $t0, $v0

	# store array address:
	la $t3, array

	# Start switch statement
    # Case 0
    beq $t0, $zero, case_0

    # Case 1
    # Initialize the i register
    li $t1, 1
    beq $t0, $t1, case_1

	# Case 2
	# Initialize the i register
    li $t1, 2
    beq $t0, $t1, case_2

    # Default case
    j default

case_0:
    # Set A[0] to 0
    sw $zero, 0($t3)

    # Break out of the switch statement
    j end_switch
case_1:
	# Empty case
	# Go to next case
	j case_2
case_2:
    # Set A[1] to 1
    li $t2, 1
    sw $t2, 4($t3)

    # Break out of the switch statement
    j end_switch

default:
    # Set A[0] to -1
    li $t2, -1
    sw $t2, 0($t3)
	# Break out of the switch statement (no jump statement needed here)

end_switch:

    # Print the value of i
    li $v0, 4
    la $a0, string_i
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    # Print the values of A
    li $v0, 4
    la $a0, string_A
    syscall

    li $v0, 1
    lw $a0, 0($t3)
    syscall

    li $v0, 4
    la $a0, string_A
    syscall

    li $v0, 1
    lw $a0, 4($t3)
    syscall

    # Exit the program
    li $v0, 10
    syscall
