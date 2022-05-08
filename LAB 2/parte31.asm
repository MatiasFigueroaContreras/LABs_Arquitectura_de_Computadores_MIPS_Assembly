.data
     mensaje: .asciiz "Ingrese el valor: "
.text
    main:
        li $v0, 4
        la $a0, mensaje
        syscall

        li $v0, 5
        syscall
        move $a1, $v0

        la $a2, 0x100100a0
        addi $s2, $zero, 2
        addi $s3, $zero, 3
        jal secuenciaCollatz
        j exit
    funcion:
        #Entradas: $a1 ; Globales: $s2, $s3
        #Salida; $v1
    	div $a1, $s2
        mfhi $t1
    	beq $t1, 0, parOperacion
        bne $t1, 0, imparOperacion
        parOperacion:
            div $v1, $a1, $s2
            jr $ra
        imparOperacion:
            mul $t1, $a1, $s3
            addi $v1, $t1, 1
            jr $ra
    secuenciaCollatz:
        #Entradas: $a1, $a2
        #Salida: en el segmento de data, esta guardada la secuencia desde la direccion de entrada $a2
    	sw $a1, 0($a2)
    	
        beq $a1, 1, back
        
        subu $sp, $sp, 4
 		sw $ra, 0($sp)
 		
        jal funcion
        move $a1, $v1
        
        lw $ra, 0($sp)
  		addi $sp, $sp, 4
        
        addi $a2, $a2, 4
        
        subu $sp, $sp, 4
 		sw $ra, 0($sp)
        
        jal secuenciaCollatz
        
        lw $ra, 0($sp)
  		addi $sp, $sp, 4
  		jr $ra
        back:
        	jr $ra
    exit:
        li $v0, 10
		syscall
