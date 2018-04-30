#Aaron

.data
search: .asciiz "Enter a number: "		
success: .asciiz "\nNumber found at index: "
failure: .asciiz "\nNumber not found"

array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 2, 14, 15, 16, 17, 18, 2
.text

main:
	la $s1, array			#$s1 = address of array1

	li $t1, 0 			#initializing $t1 to 0; this will be the counter
	li $t2, 1			#initializing $t2 to 1; essentially just for "boolean" statement
	li $t3, 20			#initializing $t3 to 20

	li $v0, 4			#print out search statement
	la $a0, search
	syscall

	li $v0, 5			#get user input
	syscall

	move $t0, $v0			#store user input in $t0
	
	j loop


loop:
	beq $t1, $t3, not_found		#when the end is reach go to not_found

	lw $t4, 0($s1)			#store element into $t4

	beq $t0, $t4, found 		#when an instance of the number is found go to found
	
sideboard:

	addi $s1, $s1, 4		#go to next element of array
	addi $t1, $t1, 1		#iterate $t1

	j loop
found:
	li $v0, 4			#print success statement
	la $a0, success
	syscall
	
	li $v0, 1			#print out index where number is found
	move $a0, $t1
	syscall
	
	li $t5, 1			#if there is at least one number in array equal to user's input set $t5 to 1

	j sideboard

not_found:
	beq $t5, $t2, final		#if there is a number equal to user input, then $t5 would be 1, so go to final instead

	li $v0, 4			#print failure statement
	la $a0, failure
	syscall
	
	j final

final:
	li $v0, 10
	syscall				#end of program