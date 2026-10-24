; Práctica: Práctica 14. Captura y almacenamiento de datos numéricos
; Alumna: Ingrid Alina Bojorquez Beltran
; Horario: 10:00 - 11:00
; Materia: Lenguajes de Interfaz
; Docente: Dr. José Luis Medina Jiménez
; Descripción: Recepción de datos numéricos como cadena (rango permitido de 1 a 99), validación de caracteres válidos, conversión a entero binario para sumar al inventario y reconversión a formato texto para visualización.

INCLUDE Irvine32.inc

.data

msgIngresoDatos BYTE "Ingrese las unidades recibidas: ", 0
msgCadenaInvalida BYTE "El programa solo acepta cadenas entre 1 y 99.", 0dh, 0ah, 0
msgResultado BYTE "Unidades Actuales: ", 0

bufferInput BYTE 10 DUP(0)

; Control de existencias
cantidadRecibida DWORD ?
existenciaInicial DWORD 25
existenciaActual DWORD ?

bufferOutput BYTE 12 DUP(0) ; Buffer de salida para el texto del resultado

.code
main PROC

IngresarDatos:
	mov edx, OFFSET msgIngresoDatos
	call WriteString

	mov edx, OFFSET bufferInput
	mov ecx, 9
	call ReadString ; Captura texto (longitud devuelta en EAX)

	; Validación de longitud (máximo 2 caracteres y no vacío)
	cmp eax, 2
	ja MostrarError

	cmp eax, 0
	je MostrarError

	mov ecx, eax ; Longitud capturada
	mov esi, 0 ; Índice de lectura
	mov edx, 0 ; Acumulador del valor numérico procesado

ConvertirCadena:
	mov al, bufferInput[esi]
	cmp al, '0'
	jb MostrarError
	cmp al, '9'
	ja MostrarError

	sub al, '0' ; Conversión de ASCII a valor numérico

	imul edx, edx, 10 ; Desplaza unidades previas a decenas
	add dl, al

	inc esi
	loop ConvertirCadena

	; Verificación de límites [1, 99]
	cmp edx, 1
	jb MostrarError
	cmp edx, 99
	ja MostrarError

	mov cantidadRecibida, edx

	; Actualización de inventario sumando a existencia base (25)
	mov eax, existenciaInicial
	add eax, cantidadRecibida
	mov existenciaActual, eax

	mov edx, OFFSET msgResultado
	call WriteString

	; Conversión de la cantidad numérica resultante a cadena imprimible
	mov eax, existenciaActual
	mov edi, OFFSET bufferOutput
	call ConvertirDecimalToString

	mov edx, OFFSET bufferOutput
	call WriteString
	call Crlf

	exit

MostrarError:
	mov edx, OFFSET msgCadenaInvalida
	call WriteString
	jmp IngresarDatos

main ENDP

; Procedimiento para convertir el valor en EAX a cadena ASCII apuntada por EDI
ConvertirDecimalToString PROC
	push eax
	push ebx
	push ecx
	push edx

	mov ecx, 0
	mov ebx, 10

ExtraerDigitos:
	mov edx, 0
	div ebx ; EAX / 10 -> Residuo en EDX
	add dl, '0' ; Código ASCII del dígito
	push dx
	inc ecx
	cmp eax, 0
	jne ExtraerDigitos

GuardarEnBuffer:
	pop dx
	mov [edi], dl
	inc edi
	loop GuardarEnBuffer

	mov byte ptr [edi], 0 ; Delimitador nulo final

	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
ConvertirDecimalToString ENDP

END main
