# Accepts an asciiz input, and prints out the string with all spaces removed
         .data
input:   .asciiz    "input: "
output:  .asciiz    "output: "
bufferI: .space     160          # Save space for the input string
bufferO: .space     160          # Save space for the output string
         .globl     main
         .text
main:
         li         $v0, 4       # System call code for print_string
         la         $a0, input   # load address of input into $a0
         syscall                 # Print the input message
         li         $v0, 8       # System call code for read_string
         la         $a0, bufferI # Load the address of the buffer
         li         $a1, 160     # Load the max string size to read
         syscall                 # Read the input string

         la         $t0, bufferI # Load the address of the input string
         lb         $t1, 0($t0)  # Load the first char of the input string
         la         $t2, bufferO # Load the address of the output string
         li         $t3, 32      # Load the ASCII value for the space character
loop:    beq        $t1, $zero, exit
                                 # Exit if end of string (denoted by a 0)
         beq        $t1, $t3, advance
                                 # If it's a space, skip copying the character
         sb         $t1, 0($t2)  # If not a space, store in the output array
         addi       $t2, $t2, 1  # and advance the index
advance: addi       $t0, $t0, 1  # Either way, advance the index of the input
         lb         $t1, 0($t0)  # Load the next char of the input
         j          loop         # Repeat the loop

exit:    li         $v0, 4       # System call code for print_string
         la         $a0, output  # load address of the output string.
         syscall
         li         $v0, 4       # System call code for print_string
         la         $a0, bufferO # load address of the output buffer into $a0
         syscall                 # Print the output string
         li         $v0, 10      # System call code for exit 
         syscall                 # Return control to system

