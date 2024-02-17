.data
    A:  .space 400      # 100 integers * 4 bytes
    nl: .asciiz "\n" 
# Assumptions
# The array A is assumed to be an array of 32-bit integers.
#The code assumes the MIPS system has system calls for printing integers (syscall 1).
#The avg calculation assumes the sum of elements can be stored in a 32-bit integer. If the sum exceeds the range, overflow may occur.


.text
    main:
        # Array A starts at address 200. Load the base address into $a0, and array size is set to 100
        la $a0, A
        li $a1, 100

        jal calculate_stats

        # Exit
        li $v0, 10
        syscall
# Initializing
calculate_stats:
        li $v0, 0           # highest value
        li $v1, 0           # lowest value
        li $t2, -1          # highest index
        li $t3, -1          # lowest index
        li $t4, 0           # sum for average

    loop:
        lw $t0, 0($a0)
        addi $a0, $a0, 4

        # Index, Highest value update, check
        bge $t0, $v0, update_highest
        j check_lowest

    update_highest:
        move $v0, $t0       # value
        li $t2, 0           # index
        j check_lowest

    check_lowest:

        ble $t0, $v1, update_lowest
        j update_average

    update_lowest:
        move $v1, $t0       
        li $t3, 0          
        j update_average

    update_average:
        add $t4, $t4, $t0   

        # Loop control
        addi $a1, $a1, -1    # Decreasing arr size
        bnez $a1, loop       # Array size not 0 means loop continues

        # average
        divu $t4, $t4, 100   
        mflo $t4            # quotient to $t4 (average)

        #finally results

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

        jr $ra               