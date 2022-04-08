.data
    mensaje: .asciiz "Ingrese los valores del vector "
    v1: .asciiz "v1:\n"
    v2: .asciiz "v2:\n"
    x1: .asciiz "Valor de x1: "
    y1: .asciiz "Valor de y1: "
    z1: .asciiz "Valor de z1: "
    x2: .asciiz "Valor de x2: "
    y2: .asciiz "Valor de y2: "
    z2: .asciiz "Valor de z2: "
    openParentheses: .asciiz "("
	closeParentheses: .asciiz ")"
	comma: .asciiz ", "
.text
    main:
        #Valores del vector v1
        li $v0, 4
		la $a0, mensaje
		syscall
        li $v0, 4
		la $a0, v1
		syscall
		
		#Se pide el valor de x1
        li $v0, 4
		la $a0, x1
		syscall
		
		#Se recibe y guarda el valor de x1
        li $v0, 5
	    syscall
 	    move $s1, $v0

		#Se pide el valor de y1
        li $v0, 4
		la $a0, y1
		syscall
		
		#Se recibe y guarda el valor de y1
        li $v0, 5
	    syscall
 	    move $s2, $v0
		
		#Se pide el valor de z1
        li $v0, 4
		la $a0, z1
		syscall
		
		#Se recibe y guarda el valor de z1
        li $v0, 5
	    syscall
 	    move $s3, $v0

        #Valores del vector v2
        li $v0, 4
		la $a0, mensaje
		syscall
        li $v0, 4
		la $a0, v2
		syscall       
		
		#Se pide el valor de x2
        li $v0, 4
		la $a0, x2
		syscall
		
		#Se recibe y guarda el valor de x2
        li $v0, 5
	    syscall
 	    move $s4, $v0
		
		#Se pide el valor de y2
        li $v0, 4
		la $a0, y2
		syscall
		
		#Se recibe y guarda el valor de y2
        li $v0, 5
	    syscall
 	    move $s5, $v0
		
		#Se pide el valor de z2
        li $v0, 4
		la $a0, z2
		syscall
		
		#Se recibe y guarda el valor de z2
        li $v0, 5
	    syscall
 	    move $s6, $v0
	
		#Imprime "("
		la $t2, openParentheses
		jal printString
        #Valor de x
        mul $t0, $s2, $s6 #$t0 = y1 * z2
        mul $t1, $s3, $s5 #$t1 = z1 * y2
        sub $a0, $t0, $t1 #$a0 = $t0 + $t1 = y1 * z2 - z1 * y2
        li $v0, 1
        syscall
		
		#Imprime ", "
		la $t2, comma
		jal printString
        #Valor de y
        mul $t0, $s3, $s4 #$t0 = z1 * x2
        mul $t1, $s1, $s6 #$t1 = x1 * z2
        sub $a0, $t0, $t1 #$a0 = $t0 + $t1 = z1 * x2 - x1 * z2
        li $v0, 1
        syscall
		
		#Imprime ", "
		la $t2, comma
		jal printString
        #Valor de y
        mul $t0, $s1, $s5 #$t0 = x1 * y2
        mul $t1, $s2, $s4 #$t1 = y1 * x2
        sub $a0, $t0, $t1 #$a0 = $t0 + $t1 = x1 * y2 - y1 * x2
        li $v0, 1
        syscall
        #Imprime ")"
		la $t2, closeParentheses
		jal printString

        li $v0, 10
		syscall	
	printString:
		#"Entrada": $t2
		#Imprime un string
		li $v0, 4
		move $a0, $t2
		syscall
		
		jr $ra #Vuelve donde quedo en el main ($ra)
