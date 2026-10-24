; Materia: Lenguajes de Interfaz
; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 13. Obtención de una cadena hexadecimal
; Horario: 10:00 - 11:00
; Descripción: Conversión de un dato numérico de 32 bits a su representación ASCII hexadecimal, aislando nibbles con máscaras lógicas y corrimientos a la derecha, para traducir cada dígito a su carácter equivalente ('0'-'9' o 'A'-'F').

INCLUDE Irvine32.inc
.data

msgHexadecimal BYTE "Numero hexadecimal: 12AB34CD", 0
msgResultado   BYTE "Cadena obtenida: ", 0 

; Buffer de 9 posiciones (8 dígitos hexadecimales + terminador nulo)
bufferHex BYTE 9 DUP(0)

.code 
main PROC 

	mov edx, OFFSET msgHexadecimal
	call WriteString
	call Crlf

	mov eax, 12AB34CDh ; Valor hexadecimal objetivo a convertir
	mov esi, 7 ; Índice apuntando al último carácter del arreglo
	mov ecx, 8 ; 8 nibbles (4 bits cada uno) para completar 32 bits

convertir:
	mov dl, al
	and dl, 0Fh ; Aislamiento del nibble inferior

	cmp dl, 9
	ja esLetra ; Si es mayor que 9, corresponde a letra ('A'-'F')

	; Mapeo para dígitos '0' a '9'
	add dl, '0'
	jmp guardarDigito

esLetra:
	; Mapeo para caracteres de 'A' a 'F' (10 -> 'A')
	sub dl, 10
	add dl, 'A'

guardarDigito:
	mov bufferHex[esi], dl ; Almacena el carácter obtenido
	shr eax, 4 ; Desplaza 4 bits a la derecha para evaluar el siguiente nibble
	dec esi ; Avanza hacia la izquierda en el buffer
	loop convertir

	; Impresión de la cadena formateada
	mov edx, OFFSET msgResultado
	call WriteString
	mov edx, OFFSET bufferHex
	call WriteString
	call Crlf 

	exit

main ENDP

END main
