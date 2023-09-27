.section .data
testdata:
    .byte 'A','0','z','P','8','r','Z','2','f','H'
.section .text
.globl _start
_start:
    subl $8,%esp
    movl $10,4(%esp)
    movl $testdata,(%esp)
    call insert_sort
# output
    call as_puts
# exit 
    call as_exit

.globl insert_sort
    .type insert_sort, @function    
insert_sort:
.LFB0:
    pushl %edi
    pushl %esi
    pushl %ebx
    movl 16(%esp),%edi  
    movl 20(%esp),%esi  
    movl %edi,%edx  
    movl %edi,%eax  
    inc %eax        
    add %esi,%edi 
    cmpl %edi,%eax  
    jge .L1
.L0:
        movb (%eax),%cl  #temp
        movl %eax,%ebx  
        dec %ebx        #ebx:a+j
        movb (%ebx),%ch  #ecx:a[j]
        cmpl %edx,%ebx
        jl .L2  
        cmpb %cl,%ch
        jle .L2  
.L3:     
        movb %ch,1(%ebx)  
        dec %ebx  
		movb (%ebx),%ch   
        cmpl %edx,%ebx
        jl .L2
        cmpb %cl,%ch
        jle .L2
        jmp .L3
.L2:
    movb %cl,1(%ebx)
    inc %eax 
    cmpl %eax,%edi 
    jle .L1  
    jmp .L0 
.L1:
    popl %ebx
    popl %esi
    popl %edi
    ret

.type as_puts, @function
as_puts:
    pushl %ebx
    movl $4, %eax
    movl $1, %ebx
    movl 8(%esp),%ecx
    movl 12(%esp),%edx
    int $0x80
    popl %ebx
    ret

.type as_exit, @function
as_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80