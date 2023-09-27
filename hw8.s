.section .data
    var:.int 0xffff
.section .text
.global __start
__start:
    addiu $sp,$sp,-24
    la $t7,20($sp)
    la $t1,var
    lw $t2,0($t1)
    li $t3,10
    li $t4,0
    beq $t2,$0,L2
L1:
    addiu $t7,$t7,-1
    addiu $t4,1
    divu $t2,$t3
    mfhi $t5
    mflo $t6
    addiu $t2,$t6,0
    addiu $t5,$t5,0x30
    sb $t5,0($t7)
    bne $t2,$0,L1
    nop
    beq $t2,$0,END

L2:
    addiu $t7,$t7,-1
    li $t5,0x30
    sb $t5,0($t7)
    li $t4,1

END:
    addiu $v0,$0,4004
    addiu $a0,$0,1
    addiu $a1,$t7,0  
    addiu $a2,$t4,0  
    syscall
    addiu $v0,$0,4001
    addiu $a0,$0,0
    syscall