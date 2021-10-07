#
#	Name:		Castrillo, Carlos
#	Project:	1
#	Due:		10/8/2021
#	Course:		cs-2640-02-f21
#
#	Description:
#			Take a number 1-99 and print out the change
#	MIPS32 Hello World!
#	cs2640
#

	.data
setchange:	.ascii	"Change by C.Castrillo\n\n"
	.asciiz "Enter the change? "

quarter:	.asciiz "Quarter: "	

dime:	.asciiz "Dime: "

nickel: .asciiz "Nickel: "

penny:	.asciiz "Penny: "

newline: .asciiz "\n"

	.text
quarterdivide:
	li		$t1, 25
	div		$t0, $t1			#divide by 25
	mflo	$t1
	mfhi	$t0
	beqz	$t1, dimedivide		#go to dime if no quarters
	la		$a0, quarter
	li		$v0, 4
	syscall						#print out quarter message
	move	$a0, $t1
	li		$v0, 1
	syscall						#print out # of quarters
	la		$a0, newline
	li		$v0, 4
	syscall
	b dimedivide				#go to dime

dimedivide:
	li		$t1, 10
	div		$t0, $t1			#divide by 10
	mflo	$t1
	mfhi	$t0
	beqz	$t1, nickeldivide	#go to nickel if no quarters
	la		$a0, dime
	li		$v0, 4
	syscall						#print out dime message
	move	$a0, $t1
	li		$v0, 1
	syscall						#print out # of nickels
	la		$a0, newline
	li		$v0, 4
	syscall
	b nickeldivide

nickeldivide:
	li		$t1, 5
	div		$t0, $t1			#divide by 5
	mflo	$t1
	mfhi	$t0
	beqz	$t1, pennydivide	#go to penny if no nickels
	la		$a0, nickel
	li		$v0, 4
	syscall						#print out nickel message
	move	$a0, $t1
	li		$v0, 1
	syscall						#print out # of nickels
	la		$a0, newline
	li		$v0, 4
	syscall
	b pennydivide

pennydivide:					#only need to check remainder
	beqz	$t0, finish
	la		$a0, penny
	li		$v0, 4
	syscall						#print out penny message
	move	$a0, $t0
	li		$v0, 1
	syscall						#print out # of pennys
	b finish

finish:
	li $v0, 10
	syscall						#ends program

main:
	la		$a0, setchange
	li		$v0, 4
	syscall						#display info and prompt change

	li		$v0, 5
	syscall						#take input

	move	$t0, $v0
	la		$a0, newline
	li		$v0, 4
	syscall

	b		quarterdivide		#start chain of divisions to find change, ends in pennydivide
