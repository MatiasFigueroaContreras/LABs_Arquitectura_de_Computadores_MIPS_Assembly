.data
    inpNum: .asciiz "Ingrese el numerador: "
    inpDen: .asciiz "Ingrese el denominador: "
    signoNeg: .asciiz "-"
    punto: .byte '.'
.text
    main:
        li $v0, 4 # Instruccion que dice al sistema que tiene que imprimir un string
        la $a0, inpNum # Texto a imprimir asignado en una direccion de memoria
        syscall # Se hace una llamada al sistema para que lo ejecute 

        li $v0, 5 # Usamos la instruccion 5 para obtener entradas de enteros
	    syscall

        move $a1, $v0

        li $v0, 4 # Instruccion que dice al sistema que tiene que imprimir un string
        la $a0, inpDen # Texto a imprimir asignado en una direccion de memoria
        syscall # Se hace una llamada al sistema para que lo ejecute 

        li $v0, 5 # Usamos la instruccion 5 para obtener entradas de enteros
	    syscall

        move $a2, $v0
        jal division
        j exit
    division:
        #Entradas: $a1, $a2
        subu $sp, $sp, 4
 		sw $ra, 0($sp)
		
		jal printSigno
		
		move $a3, $a1
		jal convertirPositivo
		move $a1, $v1
		
		move $a3, $a2
		jal convertirPositivo
		move $a2, $v1
		
		move $a3, $zero
        jal restaRecursiva

        li $v0, 4 # Instruccion que dice al sistema que tiene que imprimir un string
        la $a0, punto # Texto a imprimir asignado en una direccion de memoria
        syscall # Se hace una llamada al sistema para que lo ejecute 
		
		move $a1, $v1
		move $a0, $zero
		addi $a3, $zero, 10
		jal multiplicacion
		move $a1, $v1
		move $a3, $zero
        jal restaRecursiva
        
        move $a1, $v1
        move $a0, $zero
        addi $a3, $zero, 10
		jal multiplicacion
		move $a1, $v1
		move $a3, $zero
        jal restaRecursiva
        
 		lw $ra, 0($sp)
  		addi $sp, $sp, 4

		jr $ra
		
	printSigno:
		#Entradas: $a1, $a2
		beq $a1, $zero, numeroPositivo
		slt $t1, $a1, $zero
		slt $t2, $a2, $zero
		addi $t3, $zero, 1 
		add $t4, $t1, $t2
		beq $t4, $t3, signoNegativo
		numeroPositivo:
			jr $ra
		signoNegativo:
			li $v0, 4
			la $a0, signoNeg
			syscall
			
			jr $ra
	convertirPositivo:
		bltz $a3, negar
		move $v1, $a3
		jr $ra
		negar:
			neg $v1, $a3
			jr $ra
	restaRecursiva:
		#Entradas: $a1=numerador, $a2=denominador, $a3
		#Salida: $v1
		#Condicion
		slt $t2, $a1, $a2
    	bne $t2, $zero,finRestaRecursiva
    	#Operaciones
    	sub $a1, $a1, $a2 #Resta
    	addi $a3, $a3, 1
    	
    	#Reserva de memoria en el stack
    	subu $sp, $sp, 4
 		sw $ra, 0($sp)

    	jal restaRecursiva
    		
    	#Recuperacion de la direccion guardada en el stack, y liberacion de ese espacio de memoria
 		lw $ra, 0($sp)
  		addi $sp, $sp, 4
  			
  		jr $ra
  		finRestaRecursiva:
  			#Retorno del resultado
  			li $v0, 1
  			move $a0, $a3 
  			syscall
  				
  			move $v1, $a1 #Salida con el valor sobrante
  				
  			jr $ra #Se devuelve en la recursion
    multiplicacion:
    	#Entradas: $a0=valor sumando, $a1 = valor a multiplicar, $a3 = valor a multiplicar
    	#Salida: $v1
        beq $a3, $zero, retornoMult
        add $a0, $a0, $a1
        subi $a3, $a3, 1
 
        subu $sp, $sp, 4
 		sw $ra, 0($sp)

        jal multiplicacion

 		lw $ra, 0($sp)
  		addi $sp, $sp, 4
        
        jr $ra
        retornoMult:
        	move $v1, $a0
            jr $ra
    exit:
        li $v0, 10
		syscall
