.data
	zeroDouble: .double 0.0
	oneDouble: .double 1.0
    mensaje: .asciiz "Ingrese los valores del vector "
    v1: .asciiz "v1:\n"
    v2: .asciiz "v2:\n"
    x: .asciiz "Valor de x: "
    y: .asciiz "Valor de y: "
    z: .asciiz "Valor de z: "
.text
    main:
		ldc1 $f20, zeroDouble
		addi $s1, $zero, 24
		
		la $a0, mensaje
		jal printString
        
		la $a0, v1
		jal printString

        la $a3, 0x10010080
        jal guardarValoresVector
        move $a1, $a3

		la $a0, mensaje
		jal printString

		la $a0, v2
		jal printString

        la $a3, 0x100100a0
        jal guardarValoresVector
        move $a2, $a3

		jal distanciaEuclideana

        j exit
	distanciaEuclideana:
		#Entradas: $a1, $a2
		subu $sp, $sp, 4
 		sw $ra, 0($sp)

		jal valorDentoRaiz
        
        add.d $f12, $f2, $f20
        ldc1 $f14, oneDouble
        add.d $f22, $f14, $f14
        addi $a3, $zero, 1
        jal raizNewtonRaphson
        
        li $v0, 3
        add.d $f12, $f20, $f2
        syscall

		lw $ra, 0($sp)
  		addi $sp, $sp, 4

		jr $ra
	printString:
		#Entrada: $a0
		li $v0, 4
		syscall
		jr $ra
    guardarValoresVector:
		#Entrada: $a3
		subu $sp, $sp, 4
 		sw $ra, 0($sp)
 		
		la $a0, x
		jal printString
		
		li $v0, 7
	    syscall
		sdc1 $f0, 0($a3)
		
		la $a0, y
		jal printString
		li $v0, 7
	    syscall
		sdc1 $f0, 8($a3)
		
		la $a0, z
		jal printString
		li $v0, 7
	    syscall
		sdc1 $f0, 16($a3)
		
		lw $ra, 0($sp)
  		addi $sp, $sp, 4
		
		jr $ra
    valorDentoRaiz:
		#Entrdas: $a1, $a2
		#Salida: $f2
        beq $t3, $s1, returnValor
        add $t1, $a1, $t3
        add $t2, $a2, $t3
        ldc1 $f4, 0($t1)
        ldc1 $f6, 0($t2)
        sub.d $f8, $f4, $f6
        mul.d $f8, $f8, $f8
        add.d $f2, $f2, $f8
        addi $t3, $t3, 8

		subu $sp, $sp, 4
 		sw $ra, 0($sp)

        jal valorDentoRaiz

 		lw $ra, 0($sp)
 		addi $sp, $sp, 4
		jr $ra

		returnValor:
			jr $ra
    raizNewtonRaphson:
		#Entrdas: $f12, $f14, $a3 ; Globales $f22=2
		#Salida: $f2
    	beq $a3, 10, back
    	mul.d $f4, $f14, $f14
    	sub.d $f4, $f4, $f12
    	
    	mul.d $f6, $f14, $f22
    	
    	div.d $f8, $f4, $f6
    	
 		sub.d $f14, $f14, $f8
 		
 		
 		subu $sp, $sp, 4
 		sw $ra, 0($sp)
 		
 		addi $a3, $a3, 1
 		
 		jal raizNewtonRaphson
 		
 		lw $ra, 0($sp)
 		addi $sp, $sp, 4
 		jr $ra
		back:
			mov.d $f2, $f14
			jr $ra
    exit:
    	li $v0, 10
		syscall
