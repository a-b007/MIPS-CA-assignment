.data
A:  .word 8, 2, 9, 1, 9
n:  .word 5

.text
.globl main

main:

    lui  $a0, 0x1001
    ori  $a0, $a0, 0x0000

    lui  $t9, 0x1001
    ori  $t9, $t9, 0x0014
    lw   $a1, 0($t9)

    addi $t0, $zero, 0        # i = 0

outer_loop:
    addi $t7, $a1, -1         # n-1
    slt  $t8, $t0, $t7
    beq  $t8, $zero, exit     # if i >= n-1 exit

    addi $t1, $zero, 0        # j = 0

inner_loop:
    sub  $t6, $a1, $t0        # n - i
    addi $t6, $t6, -1         # n - i - 1

    slt  $t8, $t1, $t6
    beq  $t8, $zero, next_i   # if j >= n-i-1 go next i

    # Load A[j]
    sll  $t2, $t1, 2
    add  $t2, $t2, $a0
    lw   $t3, 0($t2)

    # Load A[j+1]
    addi $t4, $t1, 1
    sll  $t4, $t4, 2
    add  $t4, $t4, $a0
    lw   $t5, 0($t4)

    # if A[j] > A[j+1]
    slt  $t8, $t5, $t3        # (A[j+1] < A[j])
    beq  $t8, $zero, no_swap

    # swap
    sw   $t5, 0($t2)
    sw   $t3, 0($t4)

no_swap:
    addi $t1, $t1, 1
    j inner_loop

next_i:
    addi $t0, $t0, 1
    j outer_loop

exit:
    addi $v0, $zero, 10
    syscall
