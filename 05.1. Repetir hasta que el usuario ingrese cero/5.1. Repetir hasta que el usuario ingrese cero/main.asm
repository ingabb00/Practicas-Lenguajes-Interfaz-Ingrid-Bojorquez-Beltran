; Materia: Lenguajes de Interfaz
; Práctica: Práctica 5.1. Repetir hasta que el usuario ingrese cero
; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Descripción: Ciclo controlado por centinela que recibe números enteros y los imprime en consola, finalizando la ejecución cuando el usuario ingresa el valor cero.

INCLUDE Irvine32.inc
.data
    msgIngresar  BYTE "Ingrese un numero (en caso de querer terminar el programa ingresar 0): ", 0
    msgFinal   BYTE "El programa ha finalizado al ingresar 0", 0
.code
main PROC

ciclo:
    ; Solicitud y captura del valor entero
    mov edx, OFFSET msgIngresar
    call WriteString 
    call ReadInt

    ; Verificación de condición de parada (centinela = 0)
    cmp eax, 0
    je terminar ; Termina si el usuario capturó 0

    ; Muestra el número ingresado y continúa el bucle
    call WriteInt
    call Crlf
    jmp ciclo

terminar:
    mov edx, OFFSET msgFinal
    call WriteString
    call Crlf

    exit
main ENDP

END main
