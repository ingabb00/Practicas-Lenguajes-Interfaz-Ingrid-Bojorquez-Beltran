; Alumna: Ingrid Alina Bojorquez Beltran
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 3. Comparación y prueba
; Descripción: Estudio y comprobación de las instrucciones CMP y TEST, examinando el comportamiento de las banderas de estado (ZF, SF, CF y OF) mediante el volcado de registros.

INCLUDE Irvine32.inc

.code
main PROC
	
	; CASO 1: EVALUACIÓN DE BANDERA ZERO (ZF)
	; ZF se establece en 1 si el resultado de la comparación (resta implícita) es cero.
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx ; EAX y EBX son iguales -> resultado 0 -> ZF = 1
	call DumpRegs

	mov eax, 10h
	mov ebx, 10h
	cmp eax, 10h ; Comparación con valor inmediato equivalente -> activa ZF

	call DumpRegs
	
	mov eax, 0
	mov al, 000000101b ; Valor binario equivalente a 5 decimal
	cmp al, 5 ; Compara AL con 5 -> activa ZF

	call DumpRegs

	; CASO 2: EVALUACIÓN DE BANDERA DE SIGNO (SF)
	; SF se activa si el resultado aritmético tiene encendido el bit de mayor peso (signo negativo).
	mov eax, 3
	mov ebx, 4
	cmp eax, ebx ; 3 - 4 da resultado negativo -> SF = 1

	call DumpRegs

	mov eax, 0
	mov ebx, 0

	mov al, -5
	mov bl, 1
	cmp al, bl ; (-5) - 1 produce un valor negativo -> SF = 1

	call DumpRegs

	; CASO 3: EVALUACIÓN DE BANDERA DE ACARREO (CF)
	; CF detecta operaciones que generan préstamo o desbordamiento sin signo.
	mov eax, 0
	mov ebx, 0

	mov al, 5
	mov bl, 10
	cmp al, bl ; Restar un sustraendo mayor genera préstamo en aritmética sin signo -> CF = 1

	call DumpRegs

	; CASO 4: EVALUACIÓN DE DESBORDAMIENTO CON SIGNO (OF)
	; OF indica si el resultado excede el rango representable para enteros con signo.
	mov eax, 0
	mov ebx, 0

	mov al, -128 ; Valor mínimo para un entero con signo de 8 bits (-128)
	mov bl, 1
	cmp al, bl ; -128 - 1 = -129 (fuera del rango de 8 bits con signo [-128, 127]) -> OF = 1

	call DumpRegs

	; CASO 5: COMPORTAMIENTO DE LA INSTRUCCIÓN TEST
	; Ejecuta una operación AND lógica entre operandos para actualizar banderas sin alterar los datos.
	mov eax, 0

	mov al, 5 ; Representación binaria 00000101b
	test  al, 1 ; Comprueba el bit 0 (menos significativo)

	call DumpRegs

	mov al, 10000000b ; Bit 7 (bit de signo) encendido
	test al, 10000000b ; Evalúa el bit más significativo; al resultar negativo activa SF

	call DumpRegs 

	exit
main ENDP
END main
