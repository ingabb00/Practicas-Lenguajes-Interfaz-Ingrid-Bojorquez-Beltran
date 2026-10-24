; Práctica: Práctica 11. Operaciones lógicas
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Materia: Lenguajes de Interfaz
; Alumna: Ingrid Alina Bojorquez Beltran
; Descripción: Aplicación de instrucciones a nivel de bits (AND, OR, XOR y TEST) para filtrado, activación, conmutación y consulta de flags en la simulación de estados de un sistema.

INCLUDE Irvine32.inc 

.data 
    msgEncendida BYTE "alarma encendida", 0
    msgApagada   BYTE "alarma apagada", 0 

.code 
main PROC

    ; Mapa de bits simulado:
    ; Bit 0: Encendido general del equipo (1: encendido, 0: apagado)
    ; Bit 1: Señal de alarma
    ; Bit 2: Estado de conexión de red

    ; 1. Uso de AND: Filtrado y aislamiento de bits específicos
    mov eax, 0
    mov al, 00000111b
    and al, 00000010b ; Aísla el bit 1 mediante máscara
    
    call WriteBin
    call Crlf
    nop

    ; 2. Uso de OR: Encendido de bits preservando los demás
    mov eax, 0
    mov al, 00000101b ; Estado base
    or al, 00000010b ; Habilita el bit 1
    
    call WriteBin
    call Crlf 
    nop 

    ; 3. Uso de XOR: Conmutación (toggle) de bits
    mov eax, 0
    mov al, 00000101b
    
    xor al, 00000001b ; Invierte el bit 0 (simula apagar)
    call WriteBin
    call Crlf
    
    xor al, 00000001b ; Invierte nuevamente el bit 0 (simula encender)
    call WriteBin
    call Crlf
    nop 

    ; 4. Uso de TEST: Consulta no destructiva de bits
    mov al, 00000101b
    test al, 00000010b ; Comprueba si el bit 1 está en alto sin modificar AL
    
    jnz alarma_encendida ; Salta si el resultado es distinto de cero
    
    ; Caso en que la alarma está apagada
    mov edx, OFFSET msgApagada
    call WriteString
    call Crlf 
    jmp fin

alarma_encendida:
    mov edx, OFFSET msgEncendida
    call WriteString 
    call Crlf 

fin:
    exit 

main ENDP 

END main
