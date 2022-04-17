# TODO: modify the info below
# Student ID: 260843185
# Name: Your Suheng Qian
# TODO END
########### COMP 273, Winter 2022, Assignment 4, Question 1 - Tower of Hanoi ###########

.data
# TODO: add any variables here you if you need
input:.asciiz "Enter the number of the disks you want to use: "
print_step: .asciiz "\nStep "
print_move: .asciiz ":move disk "
print_from: .asciiz" from "
print_to: .asciiz " to "



# TODO END

.text
main:

    li $t8,1

    li  $v0, 4 			#ask for input
    la  $a0, input
    syscall

    jal readInt
    add $a0, $v0, $zero 	#read input and save it in v0
    
    addi $s1, $zero, 65		#A=source
    addi $s2, $zero, 67 	#C=aux
    addi $s3, $zero, 66		#B=target
    	
    jal Hanoi			#Start the process
    
    li $v0, 10	# exit the program
    syscall
    
Hanoi:        
    
    
    addi $t1, $zero, 1
    bne $a0, $t1, Recursion #if n=1 then continue in this subroutine, if not go to recursion 
    
    #move disk 1 from source to target
    move $t2,$a0 #Save n in t2 because we need a0 for syscall
    
    li $v0,4
    la $a0,print_step		#Step 
    syscall
    
    li $v0,1
    move $a0,$t8		#number of steps 
    syscall
    
    addi $t8,$t8,1
    li $v0, 4			# print move
    la $a0, print_move
    syscall
    
    li $v0,1
    move $a0,$t2		#print disk label
    syscall
    
    li $v0, 4			# print from
    la $a0, print_from
    syscall
  
    li $v0, 11 		
    move $a0, $s1		#print source
    syscall
    
    
    li $v0, 4			# print to
    la $a0, print_to
    syscall
    
    li $v0, 11 			
    move $a0, $s2		#print target
    syscall
    
    move $a0,$t2		
    
    jr $ra
Recursion:
    
    	addi $sp, $sp, -20
    
    	#Save input into the stack 
    	sw $ra, 16($sp)
    	sw $s3, 12($sp)		#aux
    	sw $s2, 8($sp)		#target
    	sw $s1, 4($sp)		#source
	sw $a0, 0($sp)		#n 
	    
    	#MOVE(n - 1, source, auxiliary, target)    
    	
    	addi $t3, $s3, 0		#Swap 
    	addi $s3, $s2, 0		
    	addi $s2, $t3, 0		
    	addi $a0, $a0, -1			
    	
    	jal Hanoi 
    	
    	
    	lw $ra, 16($sp)
    	lw $s3, 12($sp)		#load aux 
    	lw $s2, 8($sp)		#load target
    	lw $s1, 4($sp)		#load source
    	lw $a0, 0($sp)		#load n
   
    	#move disk n from source to target
    	move $t2,$a0
    	addi $t1, $zero, 1		#compare with the disk label
    	
    	li $v0,4
    	la $a0,print_step
    	syscall
    
    	li $v0,1
    	move $a0,$t8
    	syscall
    
    	addi $t8,$t8,1
    	li $v0, 4			# print move
    	la $a0, print_move
    	syscall
    	
    	li $v0,1
    	move $a0,$t2
    	syscall
    	
    	li $v0, 4			# print move
    	la $a0, print_from
    	syscall
    	
    	li $v0, 11 			#Print Source
    	move $a0, $s1
    	syscall
    	
    	
    	li $v0, 4			# print to
    	la $a0, print_to
    	syscall
    	
    	li $v0, 11 			# print end_peg
    	move $a0, $s2
    	syscall
    	
    	move $a0,$t2		# restore $a0
    
    	addi $t3, $s3, 0		
    	addi $s3, $s1, 0	#Move source to aux	
    	addi $s1, $t3, 0	#Move aux to source 	
    	addi $a0, $a0, -1				
    	
    	jal Hanoi #MOVE(n - 1, auxiliary, target, source)
    	
    	lw $ra, 16($sp)
    		
    
    	addi $sp, $sp, 20 #Restore stack
    	jr $ra    

# TODO END

	li $v0, 10	# exit the program
	syscall


# TODO: your functions here


	

# TODO END


########### Helper functions for IO ###########

# read an integer
# int readInt()
readInt:
	li $v0, 5
	syscall
	jr $ra
	
# print an integer
# printInt(int n)
printInt:
	li $v0, 1
	syscall
	jr $ra

# print a character
# printChar(char c)
printChar:
	li $v0, 11
	syscall
	jr $ra
	
# print a null-ended string
# printStr(char *s)
printStr:
	li $v0, 4
	syscall
	jr $ra
