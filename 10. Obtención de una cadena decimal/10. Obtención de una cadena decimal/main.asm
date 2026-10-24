; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Práctica: Práctica 10. Obtención de una cadena decimal
; Horario: 10:00 - 11:00
; Descripción: Cálculo de métricas de progreso de descarga (bytes completados, pendientes, paquetes de 1024 bytes y porcentaje global) junto con una subrutina propia para la conversión de valores numéricos a cadenas ASCII en base 10.

INCLUDE Irvine32.inc

.data
	msgInicio BYTE "Avance de la descarga:", 0 
	msgBytesDescargados BYTE "Bytes descargados: ", 0 
	msgBytesPendientes BYTE "Bytes pendientes: ", 0
	msgGruposCompletos BYTE "Grupos completos de 1024 bytes: ", 0 
	msgResiduo BYTE "Residuo de los agrupamientos: ", 0 
	msgPorcentaje BYTE "Porcentaje de avance de la descarga: ", 0

	; Variables de almacenamiento de métricas
	bytesDescargados DWORD ? 
	bytesPendientes DWORD ?
	gruposCompletos DWORD ? 
	residuo DWORD ? 
	porcentajeDescarga DWORD ? 

	bufferConversion BYTE 11 DUP(0) ; Buffer receptor para la cadena de texto convertida

.code
main PROC

	; 1. Cálculo de bytes transferidos (125 bloques * 512 bytes)
	mov eax, 125
	mov ebx, 512
	mul ebx
	mov bytesDescargados, eax

	; 2. Cálculo de bytes restantes para 100,000 bytes totales
	mov eax, 100000
	sub eax, bytesDescargados
	mov bytesPendientes, eax

	; 3. Determinación de grupos de 1024 bytes y su residuo
	mov eax, bytesDescargados
	mov edx, 0
	mov ebx, 1024
	div ebx
	mov gruposCompletos, eax ; Cociente
	mov residuo, edx ; Resto

	; 4. Estimación del porcentaje de transferencia
	mov eax, bytesDescargados
	mov ebx, 100
	mul ebx
	mov ebx, 100000
	div ebx
	mov porcentajeDescarga, eax

	; Despliegue de resultados formateados
	mov edx, OFFSET msgInicio
	call WriteString
	call Crlf
	call Crlf

	; Bytes transferidos
	mov edx, OFFSET msgBytesDescargados
	call WriteString 
	mov eax, bytesDescargados
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf

	; Bytes por transferir
	mov edx, OFFSET msgBytesPendientes
	call WriteString 
	mov eax, bytesPendientes
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf 

	; Paquetes enteros de 1024 bytes
	mov edx, OFFSET msgGruposCompletos
	call WriteString
	mov eax, gruposCompletos
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion 
	call WriteString 
	call Crlf

	; Residuo no agrupado
	mov edx, OFFSET msgResiduo
	call WriteString
	mov eax, residuo
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf 

	; Porcentaje total
	mov edx, OFFSET msgPorcentaje
	call WriteString
	mov eax, porcentajeDescarga
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf

	exit
main ENDP

; Procedimiento para convertir un número entero en EAX a representación en texto ASCII (apuntado por ESI)
convertirDecimal PROC

	; Preservación de registros en pila
	push eax
	push ebx 
	push ecx 
	push edx
	push esi 

	mov ecx, 0 ; Contador de caracteres/dígitos

extraer_digitos:
	mov edx, 0
	mov ebx, 10 ; Base decimal
	div ebx ; EAX / 10 -> Residuo en EDX
	push edx ; Se apila el dígito para procesar el orden correcto
	inc ecx
	cmp eax, 0
	jne extraer_digitos

construir_cadena:
	pop edx ; Recupera el dígito en orden más significativo
	mov bl, dl
	add bl, '0' ; Conversión a código ASCII
	mov [esi], bl
	inc esi
	loop construir_cadena

	mov byte ptr [esi], 0 ; Terminador nulo

	; Restauración de contexto
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
convertirDecimal ENDP

END main
