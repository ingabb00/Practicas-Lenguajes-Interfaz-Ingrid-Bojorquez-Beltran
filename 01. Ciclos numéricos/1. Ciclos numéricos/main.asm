; Materia: Lenguajes de Interfaz
; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Práctica: Práctica 1. Ciclos numéricos
; Descripción: Implementación de un ciclo que imprime una secuencia descendente del 5 al 1 empleando la instrucción loop.

INCLUDE Irvine32.inc

.data
.code
main PROC
    mov ecx, 5 ; Inicializa el contador del bucle en 5
    
ciclo:
    mov eax, ecx ; Carga el valor actual de la cuenta en EAX
    
    call WriteDec
    call Crlf
    loop ciclo ; Decrementa ECX y repite mientras no sea cero
    
    exit
main ENDP

END main
