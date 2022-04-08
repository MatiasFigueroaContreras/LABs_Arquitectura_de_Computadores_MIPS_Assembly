.data
	mensaje: .asciiz "Ingrese los valores del vector (v1):"
    x: .asciiz "\nValor de x1: "
    y: .asciiz "Valor de y1: "
    z: .asciiz "Valor de z1: "
.text
    main:
        la $s0, 0x10010060
        #Valroes Iniciales vector (v2)
        addi $t0, $zero, 7 #x2
        sw $t0, 0($s0)
        addi $t0, $zero, -5 #y2
        sw $t0, 4($s0)
        addi $t0, $zero, 13 #z2
        sw $t0, 8($s0)
		
		#Imprimir mensaje
        li $v0, 4
		la $a0, mensaje
		syscall
		
		#Imprimir x ("Valor de x1: ")
        li $v0, 4
		la $a0, x
		syscall
		
		#Multiplicar el valor de x1(dado por consola) con x2
		lw $t1, 0($s0) #x2
        jal dataMulti
        move $s1, $t2 #se guarda el valor multiplicado en el registro $s1
		
		#Imprimir y ("Valor de y1: ")
        li $v0, 4
		la $a0, y
		syscall
		
		#Multiplicar el valor de y1(dado por consola) con y2
		lw $t1, 4($s0) #y2
        jal dataMulti
        move $s2, $t2 #$s2 = y1 * y2
    	
    	#Imprimir z ("Valor de z1: ")
        li $v0, 4
		la $a0, z
		syscall
		
		#Multiplicar el valor de z1(dado por consola) con z2
        lw $t1, 8($s0) #z2
        jal dataMulti
        move $s3, $t2 #$s3 = z1 * z2
		
		#Se suman los resultados delas multiplicaciones
        add $s4, $s1, $s2
        add $a0, $s3, $s4 #se guarda en $a0 para imprimirlo
		
		#Se imprime el resultado
        li $v0, 1
        syscall
		
		#Se termina el programa
        li $v0, 10
        syscall
    dataMulti:
    	#Pide un valor entero por consola
        li $v0, 5
	    syscall
	    #Rescata el valor y lo multiplica
	    move $t0, $v0
        mul $t2, $t0, $t1

        jr $ra #Se vuelve al main
