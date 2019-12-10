#   ___________________________________________
#	
#	Programa: 			Exercicio 01 - IMC
#	Autor:    			Bruno Rimolo e Enzo Appi
#	Materia:			ORG II
#	Docente:			Lahir
#	Data criacao:  		04/11/2019
#	Ult. Atualizacao:   04/11/2019
#	___________________________________________

	.data
tabl:
	.asciiz "\n Obtenha seu IMC com base na tabela abaixo:\n
	***************************************************
	|     Resultado        |       Situacao           |
	***************************************************
	|  Abaixo de 16        |     Magreza grave        |
	|  Entre 16 e 16.99    |     Magreza moderada     |
	|  Entre 17 e 18,49    |     Magreza leve         |
	|  Entre 18.5 e 24.99  |     Saudavel             |
	|  Entre 25 e 29.99    |     Sobrepeso            |
	|  Entre 30 e 34.99    |     Obesidade grau I     |
	|  Entre 35 e 39.99    |     Obesidade grau II    |
	|  Acima de 40         |     Obesidade grau III   |
	***************************************************\n"

msg_peso:
	.asciiz "\n Entre com o seu peso [Kg]: "
msg_alt:
	.asciiz "\n Entre com sua altura [m]: "
msg_imc:
	.asciiz "\n Seu IMC e: "
msg_magro1:
	.asciiz "\n\n ****** Magreza Grave *****"
msg_magro2:
	.asciiz "\n\n **** Magreza Moderada ****"
msg_magro3:
	.asciiz "\n\n ****** Magreza Leve ******"
msg_saudavel:
	.asciiz "\n\n ******** Saudavel ********"
msg_sobrepeso:
	.asciiz "\n\n ******** Sobrepeso *******"
msg_obeso1:
	.asciiz "\n\n **** Obesidade grau I ****"
msg_obeso2:
	.asciiz "\n\n **** Obesidade grau II ***"
msg_obeso3:
	.asciiz "\n\n *** Obesidade grau III ***"

	.text
	.globl main

main:
	#-------Exibe tabela---------
	li $v0, 4
	la $a0, tabl
	syscall
	#----------------------------

	#-----Entrar com o peso------
	li $v0, 4
	la $a0, msg_peso
	syscall
	li $v0, 6
	syscall
	mov.s $f31, $f0
	#----------------------------

	#-----Entrar com o altura----
	li $v0, 4
	la $a0, msg_alt
	syscall
	li $v0, 6
	syscall
	mov.s $f30, $f0
	#----------------------------

	#--------Calcula IMC---------
	mul.s $f29, $f30, $f30       # Armazena no $f29 altura x altura
	div.s $f28, $f31, $f29       # Armazena no $f28 peso/ $f29
	#----------------------------

	#--------Exibe IMC-----------
	li $v0, 4
	la $a0, msg_imc
	syscall
	li $v0, 2 					 # Exibe numero real (tem que estar em $f12)
	mov.s $f12, $f28
	syscall
	#----------------------------

	#-------Comparacoes----------
	li.s $f1, 16.0
	c.lt.s $f12, $f1
	bc1t magro1
	nop

	li.s $f2, 17.0
	c.lt.s $f12, $f2
	bc1t magro2
	nop

	li.s $f3, 18.5
	c.lt.s $f12, $f3
	bc1t magro3
	nop

	li.s $f4, 25.0
	c.lt.s $f12, $f4
	bc1t saudavel
	nop

	li.s $f5, 30.0
	c.lt.s $f12, $f5
	bc1t sobrepeso
	nop

	li.s $f6, 35.0
	c.lt.s $f12, $f6
	bc1t obeso1
	nop

	li.s $f7, 40.0
	c.lt.s $f12, $f7
	bc1t obeso2
	nop
	j obeso3

magro1:
	li $v0, 4
	la $a0, msg_magro1
	syscall
	j exit

magro2:
	li $v0, 4
	la $a0, msg_magro2
	syscall
	j exit

magro3:
	li $v0, 4
	la $a0, msg_magro3
	syscall
	j exit

saudavel:
	li $v0, 4
	la $a0, msg_saudavel
	syscall
	j exit

sobrepeso:
	li $v0, 4
	la $a0, msg_sobrepeso
	syscall
	j exit

obeso1:
	li $v0, 4
	la $a0, msg_obeso1
	syscall
	j exit

obeso2:
	li $v0, 4
	la $a0, msg_obeso2
	syscall
	j exit

obeso3:
	li $v0, 4
	la $a0, msg_obeso3
	syscall
	j exit

exit:
	li $v0, 10  # 10 = exit
	syscall