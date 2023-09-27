.section .data
string_width:
	.asciz "%6d%c" #setw(6)
printfmessage:
	.asciz "\nnumbers: %d\n"
.section .text
.globl _start
_start:
	movl $1,%ebx	#i
	movl $0,%ecx  	#num
.INIF:
	cmpl $100,%ebx
	jg .L1
	pushl %ebx
	call choushu
	popl %ebx
	testl %eax,%eax
	je	.OUTIF
#IN IF
	incl %ecx
	pushl %ecx
	movl %ecx,%eax
	pushl %ebx
	movb $10,%bl
	idiv %bl
	popl %ebx
	testb %ah,%ah
	jnz .l2
	jz  .l3
.l2:
	movl $',',%ecx
	jmp .l4
.l3:
	movl $'\n',%ecx
.l4:
	pushl %ecx
	pushl %ebx
	pushl $string_width
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	popl %ecx
.OUTIF:
	incl %ebx
	jmp .INIF
.L1:
	pushl %ecx
	pushl  $printfmessage
	call printf
	addl $8,%esp
	pushl $0	#return 0
	call exit

.globl choushu
.type choushu, @function
choushu:
	pushl %ebp
	movl %esp,%ebp
	movl 8(%ebp),%edx	#%edx:n-parameter
.LOOP1:
	movl %edx,%eax
	movb $2,%bl
	idivb %bl
	testb %ah,%ah
	jnz .LOOP2
	movsbl %al,%edx
	jmp .LOOP1
.LOOP2:
	movl %edx,%eax
	movb $3,%bl
	idivb %bl
	testb %ah,%ah
	jnz .LOOP3
	movsbl %al,%edx
	jmp .LOOP2
.LOOP3:
	movl %edx,%eax
	movb $5,%bl
	idivb %bl
	testb %ah,%ah
	jnz .LOOPEND
	movsbl %al,%edx
	jmp .LOOP3
.LOOPEND:
	movl $1,%eax
	cmpl %eax,%edx
	jne .OUTFUNC
	popl %ebp
	ret
.OUTFUNC:
	movl $0,%eax
	popl %ebp
	ret