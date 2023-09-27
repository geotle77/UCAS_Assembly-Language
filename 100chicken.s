.section .data
printmessage:
	.asciz "%2d gongji %2d muji %2d xioaoji\n"
.section .text
.globl _start
_start:
	movl	$1, %ebx	# gongji
outloop:
	cmpl	$33, %ebx	
	jg	Outloop_end
	movl	$1, %ecx	# hens
midloop:
	cmpl	$50, %ecx
	jg	midoop_end
	movl	$1, %edi	# xaioji
innerloop:
	cmpl	$100, %edi
	jg	innerloop_end
	movl	%ebx, %eax
	addl	%ecx, %eax
	addl	%edi, %eax
	cmpl	$100, %eax	
	jne	innerloop_judge
	movl	%ebx, %eax
	movl	$3, %edx		#work register: edx
	imulb	%dl			#gongji*3
	movswl	%ax, %esi
	movl	%ecx, %eax
	sall	$1, %eax	#muji*2
	addl	%eax, %esi
	movl	%edi, %eax	
	movl	$3, %edx
	idivb	%dl		
	movsbl	%al, %eax
	addl	%eax, %esi
	cmpl	$100, %esi
	jne	innerloop_judge
#call printf
	pushl	%edi
	pushl	%ecx
	pushl	%ebx
	pushl	$printmessage
	call	printf
	addl	$4, %esp
	popl	%ebx
	popl	%ecx
	popl	%edi
innerloop_judge:
	addl	$3, %edi	#add 3 or 1
	jmp	innerloop
innerloop_end:
	addl	$1, %ecx
	jmp	midloop
midoop_end:
	addl	$1, %ebx
	jmp	outloop
Outloop_end:
	movl	$1, %eax
	movl	$0, %ebx
	int	$0x80

	
	

