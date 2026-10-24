; Docente: Dr. José Luis Medina Jiménez
; Alumna: Ingrid Alina Bojorquez Beltran
; Práctica: Práctica 8. Operaciones aritméticas
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Descripción: Pruebas prácticas de operaciones aritméticas en x86 (suma, resta, producto y división con y sin signo), examinando el comportamiento del par EDX:EAX, la extensión con CDQ y las banderas CF y OF.

INCLUDE Irvine32.inc
.data
.code
main proc 
	; 1. Suma y resta simples
	mov eax, 50 
	mov ebx, 20 

	add eax, ebx ; EAX = 50 + 20 = 70
	sub eax, 15 ; EAX = 70 - 15 = 55

	nop

	; 2. Verificación de acarreo sin signo (CF)
	mov eax, 0
	mov al, 255 ; Valor máximo de byte sin signo

	mov al, 1

	nop

	; 3. Comprobación de desbordamiento con signo (OF)
	mov eax, 0
	mov al, 127 ; Límite superior en 8 bits con signo (+127)

	add al, 1 ; Provoca overflow con signo al sobrepasar a -128

	nop

	; 4. Multiplicación sin signo (MUL) a 32 bits
	mov eax, 25
	mov ebx, 3

	mul ebx ; Producto en EAX (25 * 3 = 75)

	nop

	; 5. Multiplicación con signo (IMUL)
	mov eax, -5

	imul eax, eax, 3 ; Multiplicación con signo: -5 * 3 = -15

	; 6. Multiplicación a 64 bits resultante (EDX:EAX)
	mov eax, 65537
	mov ebx, 655537

	mul ebx ; Parte alta en EDX, parte baja en EAX
	
	nop

	; 7. División sin signo (DIV)
	mov eax, 125 ; Dividendo (parte baja)
	mov edx, 0 ; Limpia parte alta para EDX:EAX
	mov ebx, 12 ; Divisor

	div ebx ; Cociente en EAX, residuo en EDX

	nop

	; 8. División con signo (IDIV)
	mov eax, -125
	cdq ; Extensión de signo de EAX hacia EDX (formando EDX:EAX)

	mov ebx, 12 ; Divisor

	idiv ebx ; Cociente con signo en EAX, residuo en EDX

	nop
	exit
main ENDP

END main
