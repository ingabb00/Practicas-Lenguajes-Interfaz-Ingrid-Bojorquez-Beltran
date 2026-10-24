; Materia: Lenguajes de Interfaz
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Alumna: Ingrid Alina Bojorquez Beltran
; Práctica: Práctica 9. PUSH y POP
; Descripción: Uso y comportamiento de la pila del procesador x86 (modelo LIFO), operaciones PUSH y POP, respaldo/restauración de registros y conservación de contexto en llamadas a procedimientos (CALL / RET).

INCLUDE Irvine32.inc

.code
main PROC

	; SECCIÓN 1: Operaciones fundamentales de apilado y desapilado
	mov eax, 20

	push eax ; Guarda EAX en el tope de la pila (ESP desciende 4 bytes)

	nop

	mov ebx, 0

	pop ebx ; Recupera el tope de la pila en EBX (ESP asciende 4 bytes)

	nop

	; SECCIÓN 2: Demostración del orden LIFO
	mov eax, 10
	push eax ; Primer dato apilado (base relativa)

	mov eax, 20
	push eax ; Segundo dato

	mov eax, 30
	push eax ; Tercer dato (tope actual)

	nop

	pop eax ; Obtiene 30 (último en entrar)
	pop ebx ; Obtiene 20
	pop ecx ; Obtiene 10 (primero en entrar)

	; SECCIÓN 3: Preservación y restablecimiento de registros
	mov eax, 100 
	mov ebx, 200

	push eax ; Respaldo de EAX
	push ebx ; Respaldo de EBX

	mov eax, 999 ; Modificación temporal de registros
	mov ebx, 666

	pop ebx ; Restauración de EBX original
	pop eax ; Restauración de EAX original

	; SECCIÓN 4: Llamadas a subrutinas con CALL y RET
	mov eax, 111
	mov ebx, 222

	call aumentarDiez ; Invoca subrutina; guarda dirección de retorno en la pila

	nop

	exit

main ENDP

; Subrutina: incrementa EAX conservando el contenido previo de EBX
aumentarDiez PROC
	push ebx ; Salva el estado de EBX

	mov ebx, 10
	add eax, ebx ; EAX = 111 + 10 = 121

	pop ebx ; Restaura EBX a su valor original

	ret ; Retorna a la instrucción siguiente al CALL
aumentarDiez ENDP
END main
