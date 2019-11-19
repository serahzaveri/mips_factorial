######################################################################################
#                                                                                    #
#                            text segment                                            #
#                                                                                    #
######################################################################################

      .text
      .globl Main
      
Main: 
      li $v0, 4                         # 4 -> print string 
      la $a0, prompt1                   # $a0 register contains the address of the string prompt1
      syscall
      
      li $v0, 5                         # 4 -> read int where int is stored in $v0
      syscall
      
      li $t5, 0                         # initialize register t5 to 0
      add $t5, $zero, $v0               # data read is now stored in $t5
      
      li $t6, 0                         # initialize register t6 to zero
      slt $t6, $t5, $zero               # if $t5 < 0 -> $t6 = 1 else $t6 = 0
      li $t7, 1                         # initialize register t7 to one to compare
      beq $t6, $t7, Invalid             # if t6 contains 1 from slt then the data is invalid
      jal Fact
      
      li $t4, 0                         # this register stores the answer from calling Fact
      add $t4, $v0, $zero               # the answer returned is now stored in t4 register
      
      li $v0, 4                         # 4 -> print "You input:"
      la $a0, another                   # a0 needs to store the address of the register
      syscall
      
      li $v0, 1                         # 1 -> print integer
      li $a0, 1                         # re-initialize a0
      add $a0, $t5, $zero               # t5 stores N 
      syscall
      
      li $v0, 4                         # 4 -> print string
      la $a0, result                    # the address of result is stores in a0 register
      syscall
      
      li $a0, 0                         # initialize a0 to 0 to print integer
      add $a0, $t4, $zero               # t4 contains the factorial from above
      li $v0, 1                         # 1 -> print this integer
      syscall 
      
      li $v0, 4                         # 4 -> print string
      la $a0, again                     # the address from again gets stored in a0
      syscall
      
      li $v0, 12                        # 12 -> read character
      syscall
      
      li $t3, 'Y'                        # t3 holds char Y
      beq $v0, $t3, DoAgain              # if the user inputs Y the program takes place again
      
      li $v0, 10                        # 10 -> exit the program
      syscall
      
DoAgain:
      j Main
      
Invalid: 
      li $v0, 4                          # 4 -> print string
      la $a0, wrongd                     # prompt user that the data entered is invalid
      syscall
      
      li $v0, 10                        # 10 -> exit the program
      syscall
      
Fact:
      subi $sp, $sp, 8                   # Make room for 2 registers on the stack
      sw $ra, 4($sp)                     # the first registrer stores the address of the call statement
      sw $t5, 0($sp)                     # the second register stores the value of n during that recursive call
      bgtz $t5, L1                       # if t5 is greater than zero then goes to L1 
      addi $v0, $zero, 1                 # we make v0 =1 to return 1
      addi $sp, $sp, 8                   # pop 2 from the stack
      jr $ra

L1:
      addi $t5, $t5, -1                  # n-1         
      jal Fact                           # goes back to Fact label
      lw $t5, 0($sp)
      lw $ra, 4($sp)
      addi $sp, $sp, 8
      mul $v0, $t5, $v0                  # n*(fact n-1)
      jr $ra
      

########################################################################################
#                                                                                      #
#                                    data segment                                      #         
#                                                                                      #
########################################################################################
         .data
prompt1: .asciiz "Input an integer number greater than or equal to zero."
wrongd:  .asciiz "The value you entered is less than zero. This program only works with values greater than or equal to zero."
another: .asciiz "You input:"
result:  .asciiz "\nThe factorial is:"
again:   .asciiz "\nInput capital character Y if you want to calculate factorial again else input any other character"
      
