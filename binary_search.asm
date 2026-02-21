.data
    a: .word 3, 4, 7, 78, 100, 121, 256
    k_val: .word 4

.text
.globl main
main:
    la   $s0, a         #Get actual base address
    addi $s1, $zero, 0   #l = 0
    addi $s2, $zero, 6  #r = 5 (size - 1)
    lw   $s3, k_val    #Better to load k from memory too
    
loop:
    #Check if l > r
    slt  $t0, $s2, $s1      #If r < l, $t0 = 1
    bne  $t0, $zero, fail   #If r < l, jump to fail

    # mid = (l + r)/2 
    add  $t1, $s1, $s2      #t1 = l + r
    srl  $s4, $t1, 1       #mid = (l + r) / 2

    #Load a[mid] and check if a[mid] < k
    #MIPS requires calculating byte offset (index * 4)
    sll  $t2, $s4, 2        #t2 = mid * 4
    add  $t2, $t2, $s0      #t2 = address of a[mid]
    lw   $s5, 0($t2)        #$s5 = a[mid]

    slt  $t3, $s5, $s3      #If a[mid] < k, $t3 = 1
    bne  $t3, $zero, l_up   #If a[mid] < k, go to l = mid + 1

    #Check if a[mid] == k or a[mid] > k
    beq  $s5, $s3, found    #If a[mid] == k, go to found

    # r = mid - 1 (If a[mid] > k)
    addi $s2, $s4, -1       #r = mid - 1
    j    loop

l_up: 
    #l = mid + 1
    addi $s1, $s4, 1        #l = mid + 1
    j    loop

found:
    #Store result and stop execution
    add  $s6, $s4, $zero    # Store mid in result register
    j    done

fail:
    addi $s6, $zero, -1 
        # Result = -1 (not found)

done:
    # tells the simulator to stop
