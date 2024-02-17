.data
    A:  .space 400      # 100 integers * 4 bytes
    nl: .asciiz "\n"

.text
    main:
        # Assume array A starts at address 200
        la $a0, A           # Load the base address of the array into $a0
        li $a1, 100         # Set the array size to 100

        jal calculate_stats

        # Exit
        li $v0, 10
        syscall

calculate_stats:
        li $v0, 0           # Initialize highest value
        li $v1, 0           # Initialize lowest value
        li $t2, -1          # Initialize highest index
        li $t3, -1          # Initialize lowest index
        li $t4, 0           # Initialize sum for average

    loop:
        lw $t0, 0($a0)      # Load the current element into $t0
        addi $a0, $a0, 4    # Move to the next element

        # Update highest value and index
        bge $t0, $v0, update_highest
        j check_lowest

    update_highest:
        move $v0, $t0       # Update highest value
        li $t2, 0           # Update highest index
        j check_lowest

    check_lowest:
        # Check for lowest value and index
        ble $t0, $v1, update_lowest
        j update_average

    update_lowest:
        move $v1, $t0       # Update lowest value
        li $t3, 0           # Update lowest index
        j update_average

    update_average:
        add $t4, $t4, $t0   # Add the current element to the sum

        # Loop control
        addi $a1, $a1, -1    # Decrement array size
        bnez $a1, loop       # If array size is not zero, continue the loop

        # Calculate average
        divu $t4, $t4, 100   # Divide the sum by the array size
        mflo $t4            # Move the quotient to $t4 (average)

        # Print the results
        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 1
        move $a0, $v0
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 1
        move $a0, $v1
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 1
        move $a0, $t3
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 1
        move $a0, $v0
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        li $v0, 1
        move $a0, $t4
        syscall

        jr $ra               # Return

