.data
input: .word 0
newline: .asciiz "\n"
prompt: .asciiz "Enter an integer: "
output_label: .asciiz "Binary representation: "

.text
main:
  # Print the prompt.
  li $v0, 4
  la $a0, prompt
  syscall

  # Read an integer from the user.
  li $v0, 5
  syscall

  # Store the input integer in register $t0.
  move $t0, $v0

  # Set a mask register to 1 in the most significant bit.
  li $t1, 1
  sll $t1, $t1, 31

  # Print the label for the binary representation.
  li $v0, 4
  la $a0, output_label
  syscall
  
  # The storage of negative integers is already in 2's complement form, using this to print the binary representation

loop:
  # Check if the most significant bit of the mask register is set (2's complement sign bit).
  beq $t1, $zero, end_loop

  # AND the input integer with the mask register to isolate the current bit.
  and $t2, $t0, $t1

  # Check if the current bit is set.
  beqz $t2, print_zero
  print_one:
    # Print the current bit as 1 (positive or 2's complement negative).
    li $v0, 11
    li $a0, 49  # ASCII code for '1'
    syscall
    j continue_loop

  print_zero:
    # Print the current bit as 0 (2's complement positive).
    li $v0, 11
    li $a0, 48  # ASCII code for '0'
    syscall

  continue_loop:
    # Shift the mask register right by 1 bit.
    srl $t1, $t1, 1
    j loop

end_loop:

  # Print a newline character.
  li $v0, 4
  la $a0, newline
  syscall

end:
  li $v0, 10
  syscall
