.data
A:  .word 7, 3, 9, 1, 5     # int A[] = {7,3,9,1,5};
n:  .word 5                # int n = 5;

.text
.globl main

main:

    # Load base address of array A into $a0
    # $a0 = &A[0]
    lui  $a0, 0x1001
    ori  $a0, $a0, 0x0000

    # Load address of n into $t9
    lui  $t9, 0x1001
    ori  $t9, $t9, 0x0014   # address of n

    # $a1 = n
    lw   $a1, 0($t9)

    # int i = 0;
    addi $t0, $zero, 0        # $t0 = i


# for (i = 0; i < n-1; i++)

outer_loop:

    # Compute n - 1
    addi $t7, $a1, -1         # $t7 = n - 1

    # if (i < n-1)
    slt  $t8, $t0, $t7
    beq  $t8, $zero, exit     # if i >= n-1 -> exit

    # min_idx = i
    add  $t1, $t0, $zero      # $t1 = min_idx

    # j = i + 1
    addi $t2, $t0, 1          # $t2 = j


# for (j = i+1; j < n; j++)

inner_loop:

    # if (j < n)
    slt  $t8, $t2, $a1
    beq  $t8, $zero, swap     # if j >= n -> go swap

    # Load A[j]
    sll  $t3, $t2, 2          # t3 = j * 4
    add  $t3, $t3, $a0        # address of A[j]
    lw   $t4, 0($t3)          # t4 = A[j]

    # Load A[min_idx]
    sll  $t5, $t1, 2          # t5 = min_idx * 4
    add  $t5, $t5, $a0        # address of A[min_idx]
    lw   $t6, 0($t5)          # t6 = A[min_idx]

    # if (A[j] < A[min_idx])
    slt  $t8, $t4, $t6
    beq  $t8, $zero, skip_update

    # min_idx = j
    add  $t1, $t2, $zero

skip_update:
    # j++
    addi $t2, $t2, 1
    j inner_loop



# if (min_idx != i) swap

swap:

    # if (min_idx == i) skip swap
    beq  $t1, $t0, next_i

    # Load A[i]
    sll  $t3, $t0, 2          # t3 = i * 4
    add  $t3, $t3, $a0        # address of A[i]
    lw   $t4, 0($t3)          # t4 = A[i]

    # Load A[min_idx]
    sll  $t5, $t1, 2          # t5 = min_idx * 4
    add  $t5, $t5, $a0        # address of A[min_idx]
    lw   $t6, 0($t5)          # t6 = A[min_idx]

    # Perform swap
    sw   $t6, 0($t3)          # A[i] = A[min_idx]
    sw   $t4, 0($t5)          # A[min_idx] = old A[i]

next_i:
    # i++
    addi $t0, $t0, 1
    j outer_loop


exit:
    # exit program
    addi $v0, $zero, 10
    syscall