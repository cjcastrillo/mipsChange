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
divide:
	add		$t2, 1
	div		$t0, $t1			#divide by dividend
	mflo	$t1
	mfhi	$t0
	beqz	$t1, changer		#go to changer if remainder is 0
	li		$v0, 4
	syscall						#print out quarter message
	move	$a0, $t1
	li		$v0, 1
	syscall						#print out # of quarters
	la		$a0, newline
	li		$v0, 4
	syscall
	b changer					#go to changer

quarterdivide:
	li		$t1, 25				#set divisor to 25
	la		$a0, quarter		#preemptively set message to quarter
	b		divide

dimedivide:
	li		$t1, 10				#set divisor to 10
	la		$a0, dime			#preemptively set message to dime
	b		divide

nickeldivide:
	li		$t1, 5				#set divisor to 5
	la		$a0, nickel			#preemptively set message to nickel
	b		divide

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
	li		$v0, 10
	syscall						#ends program

changer:
	beq		$t2, 0, quarterdivide
	beq		$t2, 1, dimedivide
	beq		$t2, 2, nickeldivide
	beq		$t2, 3, pennydivide

main:
	la		$a0, setchange
	li		$v0, 4
	syscall						#display info and prompt change

	li		$v0, 5
	syscall						#take input

	move	$t0, $v0			#set dividend to input
	la		$a0, newline
	li		$v0, 4
	syscall

	b		changer				#start chain of divisions to find change, ends in pennydivide
