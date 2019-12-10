#   ___________________________________________
#	
#	Programa: 			Exercicio 05 - Piscina
#	Autor:    			Bruno Rimolo e Enzo Appi
#	Materia:			ORG II
#	Docente:			Lahir
#	Data criacao:  		08/11/2019
#	Ult. Atualizacao:   08/11/2019
#	___________________________________________

	.data
tabl:
	.asciiz "\n
	 __________________________________
	|\                                 \
	| \ ________________________________\
	|  |                                |
	 \ |        Area da Piscina         |
	  \|________________________________|\n"

msg_prof:
	.asciiz "\n Entre com a profundidade da piscina [m]: "  # $f30
msg_lado1:
	.asciiz "\n Entre com o primeiro lado [m]: "			# $f29
msg_lado2:
	.asciiz "\n Entre com o segundo lado [m]: "				# $f28
msg_ladrilho1:
	.asciiz "\n Entre com o lado do ladrilho [cm]: "  		# $f27
msg_ladrilho2:
	.asciiz "\n Entre com a altura do ladrilho [cm]: "  	# $f26
msg_area_l1:
	.asciiz "\n Area do lado 1 [m2]: "						# $f20
msg_area_l2:
	.asciiz "\n Area do lado 2 [m2]: "						# $f21
msg_area_l3:
	.asciiz "\n Area do lado 3 [m2]: "						# $f20
msg_area_l4:
	.asciiz "\n Area do lado 4 [m2]: "						# $f21
msg_area_l5:
	.asciiz "\n Area do fundo (lado 5) [m2]: "				# $f22
msg_tot_ladrilhos:
	.asciiz "\n Total de ladrilhos [unidade]: "				# $f25

	.text
	.globl main

main:
	#-------Exibe tabela---------
	li $v0, 4
	la $a0, tabl
	syscall
	#----------------------------

	#-----Entrar com a prof------
	li $v0, 4
	la $a0, msg_prof
	syscall
	li $v0, 6
	syscall
	mov.s $f30, $f0
	#----------------------------

	#-----Entrar com o lado 1----
	li $v0, 4
	la $a0, msg_lado1
	syscall
	li $v0, 6
	syscall
	mov.s $f29, $f0
	#----------------------------

	#-----Entrar com o lado 2----
	li $v0, 4
	la $a0, msg_lado2
	syscall
	li $v0, 6
	syscall
	mov.s $f28, $f0
	#----------------------------
	
	#-----Entrar com ladrilho----
	li $v0, 4
	la $a0, msg_ladrilho1		# lado
	syscall
	li $v0, 6
	syscall
	mov.s $f27, $f0

	li $v0, 4
	la $a0, msg_ladrilho2		 # altura
	syscall
	li $v0, 6
	syscall
	mov.s $f26, $f0
	#----------------------------

	#----------Calculos----------
	li.s $f2, 2.0
	li.s $f3, 0.01				 # m para cm
	li.s $f4, 100.0				 # cm para m
	mul.s $f20, $f30, $f29       # $f20 area lado 1
	mul.s $f21, $f30, $f28       # $f21 area lado 2
	mul.s $f22, $f28, $f29       # $f22 area fundo
	mul.s $f23, $f27, $f26		 # $f23 area ladrilhos
	mul.s $f23, $f23, $f3		 # converte area ladrilhos p metros
	div.s $f15, $f20, $f23		 # qtd ladrilhos lado 1
	cvt.w.s $f0, $f22            # converte $f15 de single para integer
	
    #beq $t3, $t0, esquerda 
	#div.s $f16, $f21, $f23		 # qtd ladrilhos lado 2
	#cvt.w.s $t0, $f15
	#div.s $f17, $f22, $f23		 # qtd ladrilhos fundo
	#cvt.w.s $t0, $f15
	#----------------------------

	#--------Exibe areas---------
	li $v0, 4
	la $a0, msg_area_l1
	syscall
	li $v0, 2
	mov.s $f12, $f20
	syscall

	li $v0, 4
	la $a0, msg_area_l2
	syscall
	li $v0, 2
	mov.s $f12, $f21
	syscall

	li $v0, 4
	la $a0, msg_area_l3
	syscall
	li $v0, 2
	mov.s $f12, $f20
	syscall

	li $v0, 4
	la $a0, msg_area_l4
	syscall
	li $v0, 2
	mov.s $f12, $f21
	syscall

	li $v0, 4
	la $a0, msg_area_l5
	syscall
	li $v0, 2 
	mov.s $f12, $f22
	syscall
	#----------------------------

exit:
	li $v0, 10  # 10 = exit
	syscall