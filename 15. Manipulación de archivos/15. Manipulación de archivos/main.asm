; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Materia: Lenguajes de Interfaz
; Práctica: Práctica 15. Manipulación de archivos
; Descripción: Creación, apertura y escritura de datos en disco en el archivo "Inventario.txt" (guardando el valor "125"), contemplando el cierre del descriptor y control de errores en cada etapa.

INCLUDE Irvine32.inc

.data 

nombreArchivo BYTE "Inventario.txt", 0 ; Nombre del archivo destino
texto BYTE "125", 0 ; Contenido a registrar en disco
archivoHandle DWORD ? ; Descriptor asignado por el sistema

mensajeExito BYTE "Archivo guardado correctamente",0
mensajeError BYTE "No se pudo guardar el archivo", 0

.code
main PROC

; 1. Creación del archivo
mov edx, OFFSET nombreArchivo
call CreateOutputFile ; Retorna handle en EAX

cmp eax, INVALID_HANDLE_VALUE
je error

mov archivoHandle, eax

; 2. Escritura de datos
mov eax, archivoHandle
mov edx, OFFSET texto
mov ecx, SIZEOF texto-1 ; Longitud sin contar terminador nulo
call WriteToFile

jc errorEscritura ; Falla si se enciende la bandera de acarreo (CF = 1)

cmp eax, SIZEOF texto-1 ; Verifica que se hayan escrito todos los bytes
jne errorEscritura

; 3. Cierre del descriptor de archivo
mov eax, archivoHandle
call CloseFile

test eax, eax ; Si retorna 0 hubo error al cerrar
jz error

mov edx, OFFSET mensajeExito
call WriteString
jmp fin

errorEscritura:
	mov eax, archivoHandle
	call CloseFile ; Asegura la liberación del descriptor antes de reportar fallo

error:
	mov edx, OFFSET mensajeError
	call WriteString

fin:
	exit
main ENDP

END main
