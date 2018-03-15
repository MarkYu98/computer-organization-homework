		.data
lowercase:	.asciiz
		"alpha\n", "bravo\n", "china\n", "delta\n", "echo\n", "foxtrot\n", "golf\n", 
		"hotel\n", "india\n", "juliet\n", "kilo\n", "lima\n", "mary\n", "november\n", 
		"oscar\n", "paper\n", "quebec\n", "research\n", "sierra\n", "tango\n", 
		"uniform\n", "victor\n", "whisky\n", "x-ray\n", "yankee\n", "zulu\n"
uppercase:	.asciiz
		"Alpha\n", "Bravo\n", "China\n", "Delta\n", "Echo\n", "Foxtrot\n", "Golf\n", 
		"Hotel\n", "India\n", "Juliet\n", "Kilo\n", "Lima\n", "Mary\n", "November\n", 
		"Oscar\n", "Paper\n", "Quebec\n", "Research\n", "Sierra\n", "Tango\n", 
		"Uniform\n", "Victor\n", "Whisky\n", "X-ray\n", "Yankee\n", "Zulu\n"
numbers:	.asciiz
		"zero\n", "First\n", "Second\n", "Third\n", "Fourth\n", 
		"Fifth\n", "Sixth\n", "Seventh\n", "Eighth\n", "Ninth\n"
word_offset:	.word
		0, 7, 14, 21, 28, 34, 43, 49, 56, 63, 71, 77, 83, 89, 99,
		106, 113, 121, 131, 139, 146, 155, 163, 171, 178, 186
num_offset:	.word 
		0, 6, 13, 21, 28, 36, 43, 50, 59, 67
		
		.text 
main:		li $v0, 12 # read a char
		syscall
		
		# is '?' ?
		li $t0, '?'
		beq $t0, $v0, exit
		
		move $s0, $v0
		
		# is number?
		li $t0, '0'
		li $t1, '9'
		sub $t0, $t0, 1
		add $t1, $t1, 1
		sgt $t2, $s0, $t0
		slt $t3, $s0, $t1
		and $t2, $t2, $t3
		bnez $t2, num
		
		# is lowercase?
		li $t0, 'a'
		li $t1, 'z'
		sub $t0, $t0, 1
		add $t1, $t1, 1
		sgt $t2, $s0, $t0
		slt $t3, $s0, $t1
		and $t2, $t2, $t3
		bnez $t2, lword
		
		#is uppercase?
		li $t0, 'A'
		li $t1, 'Z'
		sub $t0, $t0, 1
		add $t1, $t1, 1
		sgt $t2, $s0, $t0
		slt $t3, $s0, $t1
		and $t2, $t2, $t3
		bnez $t2, uword
		
		# is other character
		j other
		
num:		li $v0, 11 # print char
		li $a0, '\n'
		syscall
		li $v0, 4 # print string
		sub $t0, $s0, '0'
		sll $t0, $t0, 2
		la $t1, num_offset
		add $t1, $t1, $t0
		lw $t2, ($t1)
		la $a0, numbers
		add $a0, $a0, $t2
		syscall
		j main
		
lword:		li $v0, 11 # print char
		li $a0, '\n'
		syscall
		li $v0, 4 # print string
		sub $t0, $s0, 'a'
		sll $t0, $t0, 2
		la $t1, word_offset
		add $t1, $t1, $t0
		lw $t2, ($t1)
		la $a0, lowercase
		add $a0, $a0, $t2
		syscall
		j main
		
uword:		li $v0, 11 # print char
		li $a0, '\n'
		syscall
		li $v0, 4 # print string
		sub $t0, $s0, 'A'
		sll $t0, $t0, 2
		la $t1, word_offset
		add $t1, $t1, $t0
		lw $t2, ($t1)
		la $a0, uppercase
		add $a0, $a0, $t2
		syscall
		j main
		
other:		li $v0, 11 # print char
		li $a0, '\n'
		syscall
		li $a0, '*'
		syscall
		li $a0, '\n'
		syscall
		j main
				
exit:		li $v0, 10 # exit
		syscall
