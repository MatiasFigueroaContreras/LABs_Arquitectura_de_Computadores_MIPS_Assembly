.data
	mensaje: .asciiz "Ingrese el escalar: "
	openParentheses: .asciiz "("
	closeParentheses: .asciiz ")"
	comma: .asciiz ", "
.text
    main:
    	#Carga de la direccion donde se encuentra almacenado el vector
        la $s0, 0x10010040

       #Valroes Iniciales vector (v)
        addi $t0, $zero, 15 #x
        sw $t0, 0($s0)
        addi $t0, $zero, -8 #y
        sw $t0, 4($s0)
        addi $t0, $zero, 7 #z
        sw $t0, 8($s0)
		
		#Imprime el mensaje retroalimentatorio
		la $t2, mensaje
		jal printString

		#Pide el valor del escalar (s) por consola
        li $v0, 5
	    syscall
		
		#Se guarda el valor en el registro $t0
	    move $t0, $v0
		
		#Imprime "("
		la $t2, openParentheses
		jal printString
		# s * x
        lw $t1, 0($s0)
        jal multiplicacion
		
		#Imprime ", "
		la $t2, comma
		jal printString
		# s * y
        lw $t1, 4($s0)
        jal multiplicacion
		
		#Imprime ", "
		la $t2, comma
		jal printString
		# s * z
        lw $t1, 8($s0)
        jal multiplicacion
        #Imprime ")"
		la $t2, closeParentheses
		jal printString
		
		#Se termina el programa
		li $v0, 10
		syscall	
    multiplicacion:
    	#Se multiplican dos valores y se imprime
        li $v0, 1
        mul $a0, $t1, $t0
        syscall
        
        jr $ra #Vuelve donde quedo en el main ($ra)
	printString:
		#"Entrada": $t2
		#Imprime un string
		li $v0, 4
		move $a0, $t2
		syscall
		
		jr $ra #Vuelve donde quedo en el main ($ra)

