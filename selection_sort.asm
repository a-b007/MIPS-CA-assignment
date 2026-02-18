.data
A:  .word 7, 3, 9, 1, 5
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
    addi $t7, $a1, -1
    slt  $t8, $t0, $t7
    beq  $t8, $zero, exit

    add  $t1, $t0, $zero
    addi $t2, $t0, 1

inner_loop:
    slt  $t8, $t2, $a1
    beq  $t8, $zero, swap

    sll  $t3, $t2, 2
    add  $t3, $t3, $a0
    lw   $t4, 0($t3)

    sll  $t5, $t1, 2
    add  $t5, $t5, $a0
    lw   $t6, 0($t5)

    slt  $t8, $t4, $t6
    beq  $t8, $zero, skip_update

    add  $t1, $t2, $zero

skip_update:
    addi $t2, $t2, 1
    j inner_loop

swap:
    beq  $t1, $t0, next_i

    sll  $t3, $t0, 2
    add  $t3, $t3, $a0
    lw   $t4, 0($t3)

    sll  $t5, $t1, 2
    add  $t5, $t5, $a0
    lw   $t6, 0($t5)

    sw   $t6, 0($t3)
    sw   $t4, 0($t5)

next_i:
    addi $t0, $t0, 1
    j outer_loop

exit:
    addi $v0, $zero, 10
    syscall
