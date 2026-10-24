; Práctica: Práctica 7. Validación de formato de cadena
; Materia: Lenguajes de Interfaz
; Alumna: Ingrid Alina Bojorquez Beltran
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Descripción: Validación de estructura de un texto ingresado por teclado para que cumpla con el formato de 3 letras mayúsculas, un delimitador '-' y 3 caracteres numéricos, notificando cada posible error.

INCLUDE Irvine32.inc

.data
    msgInicio BYTE "Ingrese una cadena: ", 0
    msgLongitud BYTE "La longitud de la cadena no es de 7 caracteres.", 0
    msgLetras BYTE "La cadena no cumple con la cantidad de 3 letras mayusculas al inicio.", 0
    msgSeparador BYTE "La cadena no cumple con el formato de un separador en la posicion 4.", 0
    msgDigitos BYTE "La cadena no cumple con la cantidad de 3 digitos al final.", 0
    msgCadenaValida BYTE "La cadena cumple con el formato deseado.", 0

    buffer BYTE 20 DUP(0) ; Memoria asignada para la lectura de la cadena

.code
main PROC

solicitarCadena:
    call Crlf
    
    mov edx, OFFSET msgInicio
    call WriteString

    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString ; EAX almacena los caracteres ingresados

    ; 1. Verificación de longitud exacta (7 caracteres)
    cmp eax, 7
    jne longitudInvalida

    ; 2. Verificación de delimitador en la cuarta posición (índice 3)
    mov al, buffer[3]
    cmp al, '-'
    jne separadorInvalido

    ; 3. Comprobación de 3 letras mayúsculas iniciales ('A' a 'Z')
    mov esi, 0
    mov ecx, 3

corroborarLetras:
    mov al, buffer[esi]
    cmp al, 'A'
    jb letrasInvalidas
    cmp al, 'Z'
    ja letrasInvalidas

    inc esi
    loop corroborarLetras

    ; 4. Comprobación de 3 caracteres numéricos finales ('0' a '9')
    mov esi, 4
    mov ecx, 3

cicloDigitos:
    mov al, buffer[esi]
    cmp al, '0'
    jb digitosInvalidos
    cmp al, '9'
    ja digitosInvalidos

    inc esi
    loop cicloDigitos

    ; Éxito: formato correcto
    mov edx, OFFSET msgCadenaValida
    call WriteString
    call Crlf
    jmp fin

; Manejadores de errores de formato
longitudInvalida:
    mov edx, OFFSET msgLongitud
    call WriteString
    call Crlf
    jmp solicitarCadena

separadorInvalido:
    mov edx, OFFSET msgSeparador
    call WriteString
    call Crlf
    jmp solicitarCadena

letrasInvalidas:
    mov edx, OFFSET msgLetras
    call WriteString
    call Crlf
    jmp solicitarCadena

digitosInvalidos:
    mov edx, OFFSET msgDigitos
    call WriteString
    call Crlf
    jmp solicitarCadena

fin:
    exit
main ENDP
END main
