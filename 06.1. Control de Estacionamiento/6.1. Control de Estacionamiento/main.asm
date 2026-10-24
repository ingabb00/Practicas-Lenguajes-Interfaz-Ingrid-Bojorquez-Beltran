; Alumna: Ingrid Alina Bojorquez Beltran
; Práctica: Práctica 6.1. Control de Estacionamiento
; Materia: Lenguajes de Interfaz
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Descripción: Control de aforo para un estacionamiento mediante incrementos (entradas) y decrementos (salidas), finalizando cuando se alcanza la capacidad tope de 10 vehículos.

INCLUDE Irvine32.inc

.data
    msgInicial BYTE "Ingrese 1 (entra) o 2 (sale): ", 0
    msgEntrada BYTE "Un vehiculo ha ingresado", 0
    msgSalida BYTE "Un vehiculo ha salido", 0
    msgFull BYTE "El estacionamiento esta lleno", 0
    msgInvalido BYTE "Opcion no valida. Intente de nuevo.", 0

    limiteEstacionamiento = 10 ; Cupo máximo admitido

.code
main PROC
    mov ebx, 0 ; Contador de vehículos registrados

FlujoEstacionamiento:
    call Crlf 
    mov edx, OFFSET msgInicial
    call WriteString
    call ReadInt

    ; Bifurcación según la selección
    cmp eax, 2
    je vehiculoSale

    cmp eax, 1
    je vehiculoEntra

    ; Gestión de comandos no válidos
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf
    jmp FlujoEstacionamiento

vehiculoEntra:    
    inc ebx ; Aumenta el registro de coches
    mov edx, OFFSET msgEntrada
    call WriteString
    call Crlf
    
    cmp ebx, limiteEstacionamiento ; Verifica si se llegó al tope
    je estLleno

    jmp FlujoEstacionamiento

vehiculoSale:
    ; Evita que el conteo baje de cero
    cmp ebx, 0
    jle noHayAutos

    dec ebx ; Descuenta un automóvil
    mov edx, OFFSET msgSalida
    call WriteString
    call Crlf

noHayAutos:
    jmp FlujoEstacionamiento

estLleno:
    call Crlf
    mov edx, OFFSET msgFull ; Notificación de aforo saturado
    call WriteString
    call Crlf

    exit
main ENDP

END main
