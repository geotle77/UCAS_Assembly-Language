.section .data
stringvar:
.ascii	"0123456789abcdef"
.section .text
.globl _start
_start:
    movl $0,%edx
    movl $stringvar,%ecx
  LOOP:
    movw (%ecx,%edx,2),%ax
    xchg %al,%ah
    movw %ax,(%ecx,%edx,2)
    inc %edx
    cmp $0x8,%edx
    jbe LOOP
#output
    movl    $4, %eax
    movl    $1, %ebx
    movl    $stringvar, %ecx
    movl    $16, %edx
    int    $0x80
#exit
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80

