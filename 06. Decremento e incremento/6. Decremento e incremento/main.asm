; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Alumna: Ingrid Alina Bojorquez Beltran
; Materia: Lenguajes de Interfaz
; Práctica: Práctica 6. Decremento e incremento
; Descripción: Simulación de acceso por clave PIN con un límite de tres intentos controlados por decremento (DEC), autorizando el acceso o bloqueando el sistema si se agotan las oportunidades.

INCLUDE Irvine32.inc
.data
	msgPIN BYTE "Ingrese el PIN: ", 0
	msgIntentos BYTE "Intentos restantes: ", 0
	msgError BYTE "PIN incorrecto.", 0
	msgAcceso BYTE "Acceso permitido", 0
	msgBloqueado BYTE "Autodestruccion comenzada...", 0

	pinCorrecto = 1234 ; Clave válida predefinida

.code
	main PROC
	mov ebx, 3 ; Se inicializa el total de oportunidades en 3

intentar:
	; Petición y captura del PIN
	mov edx, OFFSET msgPIN
	call WriteString
	call ReadInt

	cmp eax, pinCorrecto ; Verifica si la clave introducida coincide
	je acceso ; Acceso exitoso si coinciden

	mov edx, OFFSET msgError
	call WriteString
	call Crlf

	dec ebx ; Reduce en 1 el contador de intentos restantes

	jz bloqueado ; Si se agotan los intentos (EBX = 0), bloquea el acceso

	; Informa sobre las oportunidades disponibles
	mov edx, OFFSET msgIntentos
	call WriteString

	mov eax, ebx
	call WriteDec
	call Crlf

	jmp intentar ; Nueva solicitud de PIN

acceso:
	mov edx, OFFSET msgAcceso
	call WriteString
	call crlf
	jmp fin

bloqueado:
	mov edx, OFFSET msgBloqueado
	call WriteString
	call Crlf
	jmp fin

fin:
	exit
main ENDP

END main
