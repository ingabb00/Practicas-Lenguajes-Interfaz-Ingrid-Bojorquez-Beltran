; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Alumna: Ingrid Alina Bojorquez Beltran
; Horario: 10:00 - 11:00
; Práctica: Práctica 4. Saltos
; Descripción: Evaluación de valores numéricos mediante la instrucción CMP y bifurcación de flujo empleando saltos condicionales (JE) e incondicionales (JMP).

INCLUDE Irvine32.inc
.data
msgIguales Byte "Los numeros son iguales", 0 
msgDiferentes Byte "Los numeros son diferentes", 0

.code
main PROC

	; Carga de valores para comparar
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx ; Realiza la comparación entre registros
	
	je iguales ; Si son iguales (ZF = 1), bifurca hacia 'iguales'

	mov edx, OFFSET msgDiferentes ; En caso contrario, muestra mensaje de desigualdad
	call WriteString

	jmp fin ; Evita entrar a la sección de igualdad

	iguales:
		mov edx, OFFSET msgIguales
		call WriteString
	
	fin:
		call Crlf
 exit
main ENDP
END main
