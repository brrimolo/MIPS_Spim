#   ___________________________________________
#	
#	Programa: 			Exercicio 03 - Hospital
#	Autor:    			Bruno Rimolo e Enzo Appi
#	Materia:			ORG II
#	Docente:			Lahir
#	Data criacao:  		06/11/2019
#	Ult. Atualizacao:   06/11/2019
#	___________________________________________

    .data
tabl:
	.asciiz "\n
	***************************************
	|          Hospital FEMASS            |
	***************************************\n"
msg_1:
	.asciiz "\n Entre com o numero do quarto: "
msg_esq:
	.asciiz "\n <<< Dobre a ESQUERDA no corredor <<< \n"
msg_dir:
	.asciiz "\n >>> Dobre a DIREITA no corredor >>> \n"

    .text
    .globl main

main:
	#-------Exibe tabela---------
	li $v0, 4
	la $a0, tabl
	syscall
	#----------------------------
	
    #-----Entrada do usuario-----
    li $v0, 4
    la $a0, msg_1
    syscall
    li $v0, 5
    syscall
    #----------------------------
    
    #--------Calculo-------------
    move $t1, $v0
    li $t0, 1
    li $t2, 2
    div $t3, $t1, $t2
    mfhi $t3                     # move o resto da divisao do reg $HI para $t3
    beq $t3, $t0, esquerda       # condicional 
    j direita
    #----------------------------

esquerda:
    li $v0, 4
	la $a0, msg_esq
	syscall
    j exit

direita:
	li $v0, 4
	la $a0, msg_dir
	syscall
    j exit

exit:
    li $v0, 10
    syscall
