# Uses part 1 to compute the product of corresponding elements in two arrays
         .data
array1:  .byte      9, 13, 10, 20, 1, 6, 9, 14
                                 # Loads the array A
array2:  .byte      41, 3, 5, 7, 19, 2, 1, 7
                                 # Loads the array B
array3:  .space     40           # Allocate 40 consecutive bytes
                                 # This will be a 10-element integer array
product: .asciiz    "Product = "
comma:   .asciiz    ", "

         .globl     main
         .text
main:
         la         $t0, array1  # Load the address of array1[0]
         la         $t1, array2  # Load the address of array2[0]
         la         $t2, array3  # Load the address of array3[0]
         li         $t3, 0       # Initialize the array counter
         li         $t4, 10      # Initialize array end point
aloop:   beq        $t3, $t4, exit
         lb         $t5, 0($t0)  # Load the next byte of array A
         lb         $t6, 0($t1)  # Load the next byte of array B
         j          m            # Multiply the two numbers (stored in $t8)
endm:    sw         $t8, 0($t2)  # Store the result as a word in array3
         addi       $t0, $t0, 1  # Increment the array addresses (next 2 lines)
         addi       $t1, $t1, 1
         addi       $t2, $t2, 4
         addi       $t3, $t3, 1  # Increment the array counter
         j          aloop        # Begin again for the next element

m:       li         $t7, 1       # Initialize the counter to 1
         move       $t8, $t6     # Initialize the accumulator to y
mloop:   beq        $t5, $t7, endm
                                 # End the subroutine if the multiplication is over
         add        $t8, $t8, $t6# Add y to the accumulator
         addi       $t7, $t7, 1  # Add 1 to the counter
         j          mloop        # Return to the beginning to check the count

exit:    li         $v0, 4       # System call code for print_string
         la         $a0, product # load address of product string into $a0
         syscall                 # Print the product message
         li         $t3, 1       # Initialize the array counter
         li         $t4, 9       # Initialize array end point
         la         $t0, array3  # Load the address of the first element of array3
         lw         $t1, 0($t0)  # Load the first element of array3
ploop:   beq        $t3, $t4, end# Jumps to label end if the array is done printing
         li         $v0, 1       # System call code for print_int
         move       $a0, $t1     # Pass current element as an argument
         syscall                 # Print the current integer
         li         $v0, 4       # System call code for print string
         la         $a0, comma   # Load address of newline character
         syscall                 # Print a comma
         addi       $t0, $t0, 4  # Advance the address
         lw         $t1, 0($t0)  # Load the new element
         addi       $t3, $t3, 1  # Increment the array counter
         j          ploop        # Repeat the print loop

end:     li         $v0, 10      # System call code for exit 
         syscall                 # Return control to system

