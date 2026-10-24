; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Práctica: Práctica 12. Desplazamiento y rotación
; Horario: 10:00 - 11:00
; Alumna: Ingrid Alina Bojorquez Beltran
; Descripción: Análisis de operaciones a nivel de bits en x86: desplazamientos lógicos y aritméticos (SHL, SHR, SAR) y rotaciones simples o con acarreo (ROL, ROR, RCL, RCR), evaluando tanto desplazamientos con constantes como mediante el registro CL.

INCLUDE Irvine32.inc

.code 
main PROC 
	mov eax, 0

	; 1. SHL: Desplazamiento lógico a la izquierda (rellena con 0 a la derecha)
	mov al, 00000110b ; Valor decimal 6
	shl al, 1         ; Equivale a multiplicar por 2
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 2. SHR: Desplazamiento lógico a la derecha (rellena con 0 por la izquierda)
	mov al, 00001100b ; Valor decimal 12
	shr al, 1         ; Equivale a división entera sin signo entre 2
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 3. SAR: Desplazamiento aritmético a la derecha (preserva signo en MSB)
	mov al, -8
	sar al, 1         ; Conserva el bit de signo (-8 / 2 = -4)
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 4. Desplazamiento multibit con constante inmediata
	mov al, 00001100b
	shl al, 2         ; Corrimiento de 2 bits a la izquierda (x4)

	call DumpRegs
	call WriteBin
	call Crlf

	; 5. Desplazamiento con cantidad variable en registro CL
	mov al, 00010100b ; Decimal 20
	mov cl, 2
	shr al, cl        ; Desplaza 2 bits a la derecha

	call DumpRegs
	call WriteBin
	call Crlf

	; 6. ROL: Rotación circular a la izquierda
	mov al, 00000011b
	rol al, 1         ; El bit saliente por la izquierda reingresa por la derecha
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 7. ROR: Rotación circular a la derecha
	mov al, 11000000b
	ror al, 1         ; El bit saliente por la derecha entra por la izquierda
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 8. RCL: Rotación circular a la izquierda pasando por la bandera CF
	mov al, 10100000b
	rcl al, 1         ; El MSB va a CF y el valor anterior de CF entra como LSB
	
	call DumpRegs
	call WriteBin
	call Crlf

	; 9. RCR: Rotación circular a la derecha pasando por la bandera CF
	mov al, 00000101b
	rcr al, 1         ; El LSB va a CF y el valor previo de CF entra en MSB
	
	call DumpRegs
	call WriteBin
	call Crlf

	exit

main ENDP

END main
