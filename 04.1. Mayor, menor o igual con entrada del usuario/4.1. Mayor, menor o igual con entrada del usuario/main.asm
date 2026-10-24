; Práctica: Práctica 4.1. Mayor, menor o igual con entrada del usuario
; Docente: Dr. José Luis Medina Jiménez
; Alumna: Ingrid Alina Bojorquez Beltran
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Descripción: Captura dos enteros proporcionados por teclado, compara sus magnitudes mediante la instrucción CMP y determina si el primer valor es mayor, menor o igual haciendo uso de saltos JE y JL.

INCLUDE Irvine32.inc

.data
msgIngresar1 BYTE "Ingresa el primer valor: ", 0
msgIngresar2 BYTE "Ingresa el segundo valor: ", 0
msgMayor   BYTE "El primer numero es mayor.", 0
msgMenor   BYTE "El primer numero es menor.", 0
msgIguales BYTE "Los numeros son iguales.", 0

.code
main PROC

    ; Captura del primer número
    mov edx, OFFSET msgIngresar1
    call WriteString 
    call ReadInt
    mov ecx, eax ; Preserva el primer número en ECX

    ; Captura del segundo número
    mov edx, OFFSET msgIngresar2
    call WriteString 
    call ReadInt
    mov ebx, eax ; Almacena el segundo dato en EBX
    
    mov eax, ecx ; Recupera el primer valor para la comparación

    cmp eax, ebx ; Evalúa primer valor vs segundo valor

    je iguales ; Salta si son idénticos
    jl menor ; Salta si el primero es menor con signo

    ; Si no se cumple ninguna anterior, el primer número es mayor
    mov edx, OFFSET msgMayor
    call WriteString
    jmp fin

iguales:
    mov edx, OFFSET msgIguales
    call WriteString
    jmp fin

menor:
    mov edx, OFFSET msgMenor
    call WriteString

fin: 
    call Crlf
    exit

main ENDP
END main
