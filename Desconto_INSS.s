#   ___________________________________________
#	
#	Programa: 			Exercicio 02 - INSS
#	Autor:    			Bruno Rimolo e Enzo Appi
#	Materia:			ORG II
#	Docente:			Lahir
#	Data criacao:  		05/11/2019
#	Ult. Atualizacao:   05/11/2019
#	___________________________________________

	.data
tabl:
	.asciiz "\n
	***************************************************
	|     Faixa Salarial        |      Desconto       |
	|***************************|*********************|
	|  Ate 1751.81              |        8%           |
	|  de 1751.82 ate 2919.72   |        9%           |
	|  de 2919.73 ate 5839.45   |       11%           |
	|  Acima de 5839.45         |  (Teto) R$ 642,34   |
	***************************************************\n"

msg_salario:
	.asciiz "\n Entre com seu salario bruto: R$ "
msg_salario2:
	.asciiz "\n Seu salario com desconto e: R$ "
msg_desc8:
	.asciiz "\n\n ****** Desconto de 8% ******"
msg_desc9:
	.asciiz "\n\n ****** Desconto de 9% ******"
msg_desc11:
	.asciiz "\n\n ****** Desconto de 11% *****"
msg_teto:
	.asciiz "\n\n * Teto: Desconto R$ 642,34 *"

	.text
	.globl main
main:
	#-------Exibe tabela---------
	li $v0, 4
	la $a0, tabl
	syscall
	#----------------------------
	#-------Entra salario--------
	li $v0, 4
	la $a0, msg_salario
	syscall
	li $v0, 6
	syscall
	mov.s $f30, $f0
	#----------------------------

	#-----Define Porcentagens----
	li.s $f4, 0.92		# 92% para multiplicar e chegar no 8% de desconto
	li.s $f5, 0.91		# 91% para multiplicar e chegar no 9% de desconto
	li.s $f6, 0.89		# 89% para multiplicar e chegar no 11% de desconto
	li.s $f7, 642.34 	# Teto de contribuicao
	#----------------------------

	#-------Comparacoes----------
	li.s $f1, 1751.81
	c.le.s $f30, $f1
	bc1t desc8
	nop

	li.s $f2, 2919.72
	c.le.s $f30, $f2
	bc1t desc9
	nop

	li.s $f3, 5839.45
	c.le.s $f30, $f3
	bc1t desc11
	nop
	j teto
	#----------------------------

desc8:
	li $v0, 4
	la $a0, msg_desc8
	mul.s $f8, $f30, $f4
	syscall
	j exit

desc9:
	li $v0, 4
	la $a0, msg_desc9
	mul.s $f8, $f30, $f5
	syscall
	j exit

desc11:
	li $v0, 4
	la $a0, msg_desc11
	mul.s $f8, $f30, $f6
	syscall
	j exit

teto:
	li $v0, 4
	la $a0, msg_teto
	sub.s $f8, $f30, $f7
	syscall
	j exit

exit:
	#----Salario com desconto----
	li $v0, 4
	la $a0, msg_salario2
	syscall
	li $v0, 2
	mov.s $f12, $f8
	syscall
	#----------------------------
	li $v0, 10
	syscall