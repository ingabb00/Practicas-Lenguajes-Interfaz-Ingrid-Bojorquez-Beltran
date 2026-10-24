; Horario: 10:00 - 11:00
; Materia: Lenguajes de Interfaz
; Docente: Dr. José Luis Medina Jiménez
; Alumna: Ingrid Alina Bojorquez Beltran
; Práctica: Práctica 5. Condicionales
; Descripción: Demostración de estructuras iterativas While y Do-While en lenguaje ensamblador, desplegando una secuencia numérica del 1 al 100 para cada caso mediante saltos condicionales.

INCLUDE Irvine32.inc
.data
    msgWhile BYTE "Ciclo While", 0 
    msgDoWhile BYTE "Ciclo Do While", 0
.code
main PROC

    ; Encabezado de la prueba While
    mov edx, OFFSET msgWhile
    call WriteString
    call Crlf

    mov ebx, 1 ; Inicialización de variable de control

cicloWhile:
    cmp ebx, 100 ; Condición previa: evaluar si supera 100
    jg finWhile ; Termina si el contador es estrictamente mayor a 100
    
    mov eax, ebx
    call WriteDec
    call Crlf

    inc ebx ; Incremento del iterador
    jmp cicloWhile
finWhile:
    call Crlf

    ; Encabezado de la prueba Do-While
    mov edx, OFFSET msgDoWhile
    call WriteString
    call Crlf

    mov ebx, 1 ; Reinicio del valor inicial

cicloDoWhile:

    mov eax, ebx
    call WriteDec
    call Crlf

    inc ebx
    cmp ebx, 100 ; Condición posterior: verifica si continúa dentro del rango
    jle cicloDoWhile ; Si es menor o igual a 100, repite la iteración

    exit
main ENDP

END main
