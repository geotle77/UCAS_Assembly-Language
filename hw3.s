.section .data
iostring:
  .asciz "ab1g2hA0H56po9wK78nB"
.section .text
.globl _start
_start:
    mov $iostring, %edx
L1:
    mov (%edx),%al
    test %al,%al
    je L2
    cmp $'a',%al
    jb L3
    cmp $'z',%al
    ja L3
    subb $0x20,%al
    mov %al,(%edx)
    inc %edx
    jmp L1
L3:
    inc %edx
    jmp L1
L2:
    mov %al,(%edx)
#output
    movl    $4, %eax
    movl    $1, %ebx
    movl    $iostring, %ecx
    sub     %ecx,%edx 
    int    $0x80
#exit
    movl    $1, %eax
    movl    $0, %ebx
    int    $0x80