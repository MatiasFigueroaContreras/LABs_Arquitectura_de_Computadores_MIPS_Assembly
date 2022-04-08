.data
	reservedSpace: .space 0x0000000C #Se reserva el espacio que ocupara el primer vector, para evitar perdida de los strings de abajo
	openParentheses: .asciiz "("
	closeParentheses: .asciiz ")"
	comma: .asciiz ", "
.text
	main:
		#Direcciones donde estaran los valores de los vectores v1 y v2
		la $s1, 0x10010000
		la $s2, 0x10010020
		
		#Valroes Iniciales
		#v1
		addi $t0, $zero, 4 #x1
		sw $t0, 0($s1)
		addi $t0, $zero, 6 #y1
		sw $t0, 4($s1)
		addi $t0, $zero, 5 #z1
		sw $t0, 8($s1)
		
		#v2
		addi $t0, $zero, -3 #x2
		sw $t0, 0($s2)
		addi $t0, $zero, 1 #y2
		sw $t0, 4($s2) 
		addi $t0, $zero, 15 #z2
		sw $t0, 8($s2)
		
		#Imprime "("
		la $t2, openParentheses
		jal printString
		#x1 + x2
		lw $t0, 0($s1)
		lw $t1, 0($s2)
		jal suma
		
		
		#Imprime ", "
		la $t2, comma
		jal printString
		#y1 + y2
		lw $t0, 4($s1)
		lw $t1, 4($s2)
		jal suma
		
		#Imprime ", "
		la $t2, comma
		jal printString
		#z1 + z2
		lw $t0, 8($s1)
		lw $t1, 8($s2)
		jal suma
		#Imprime ")"
		la $t2, closeParentheses
		jal printString
		
		li $v0, 10
		syscall	
	suma:
		#Se suman dos valores y se imprime
		li $v0, 1
		add $a0, $t0, $t1
		syscall
		
		jr $ra #Vuelve donde quedo en el main ($ra)
	printString:
		#"Entrada": $t2
		#Imprime un string
		li $v0, 4
		move $a0, $t2
		syscall
		
		jr $ra #Vuelve donde quedo en el main ($ra)
		
		
		
		
