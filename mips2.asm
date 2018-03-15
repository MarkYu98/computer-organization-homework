		.data
succ_msg:	.asciiz	"\nSuccess! Location: "
fail_msg:	.asciiz	"\nFail!\n"
buffer:		.space 500

		.text
main:		li $v0, 8 # read string (maxlen=500)
		la $a0, buffer
		la $a1, 500
		syscall
		move $s2, $a1 # length

findchar:	li $v0, 12 # read a char
		syscall
		
		# is '?' ?
		li $t0, '?'
		beq $t0, $v0, exit
		la $s0, buffer
		li $t0, 0
		
loop:		lb $t2, ($s0)
		beq $v0, $t2, success
		add $t0, $t0, 1
		slt $t1, $t0, $s2
		beqz $t1, fail
		add $s0, $s0, 1
		j loop

success:	li $v0, 4 # print string
		la $a0, succ_msg
		syscall
		li $v0, 1 # print integer
		add $a0, $t0, 1
		syscall
		li $v0, 11 # print char
		li $a0, '\n'
		syscall
		j findchar
		
fail:		li $v0, 4 # print string
		la $a0, fail_msg
		syscall
		j findchar
		
exit:		li $v0, 10 # exit
		syscall
