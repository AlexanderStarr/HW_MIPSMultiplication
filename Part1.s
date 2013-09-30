# Multiplies two 8-bit unsigned integers (range 0-255) x and y.
         .data
enterX:  .asciiz    "Enter x: "
enterY:  .asciiz    "Enter y: "
product: .asciiz    "Product = "
         .globl     main
         .text
main:
# First block prompts the user and reads the two input integers

         li         $v0, 4       # System call code for print_string
         la         $a0, enterX  # load address of enterX into $a0
         syscall                 # Print the prompt
         li         $v0, 5       # System call code for read_int
         syscall                 # Read the int (result stored in $v0)
         move       $t1, $v0     # Store entered int in $t1

         li         $v0, 4       # System call code for print_string
         la         $a0, enterY  # load address of enterY into $a0
         syscall                 # Print the prompt
         li         $v0, 5       # System call code for read_int
         syscall                 # Read the int (result stored in $v0)
         move       $t2, $v0     # Store entered int in $t2

# Second block performs the multiplication using repeated addition
        
         li         $t0, 1       # Initialize the counter to 1
         move       $t3, $t2     # Initialize the accumulator to y
loop:    beq        $t0, $t1, exit
                                 # If the counter has reached x, then exit
         add        $t3, $t3, $t2# Add y to the accumulator
         addi       $t0, $t0, 1  # Add 1 to the counter
         j          loop         # Return to the beginning to check the counter

exit:    li         $v0, 4       # System call code for print_string
         la         $a0, product # load address of the product string
         syscall                 # Print the product string
         li         $v0, 1       # System call code for print_int
         move       $a0, $t3     # Load the integer result
         syscall                 # Print the result
         li         $v0, 10      # System call code for exit 
         syscall                 # Return control to system

