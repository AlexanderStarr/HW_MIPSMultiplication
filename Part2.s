# Uses part 1 to compute the product of corresponding elements in two arrays
         .data
array1:  .byte 9, 13, 10, 20, 1, 6, 9, 14
                                 # Loads the array A
array2:  .byte 41, 3, 5, 7, 19, 2, 1, 7
                                 # Loads the array B
array3:  .space 40               # Allocate 40 consecutive bytes
product: .asciiz    "Product = "

         .globl     main
         .text
main:
         li         $v0, 4       # System call code for print_string
         la         $a0, product # load address of product string into $a0
         syscall                 # Print the product message
         li         $v0, 10      # System call code for exit 
         syscall                 # Return control to system

