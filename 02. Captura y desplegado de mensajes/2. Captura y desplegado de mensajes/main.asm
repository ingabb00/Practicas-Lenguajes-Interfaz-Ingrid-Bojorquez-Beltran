; Práctica: Práctica 2. Captura y desplegado de mensajes
; Alumna: Ingrid Alina Bojorquez Beltran
; Materia: Lenguajes de Interfaz
; Docente: Dr. José Luis Medina Jiménez
; Horario: 10:00 - 11:00
; Descripción: Solicita la captura del nombre del usuario mediante la consola, lo guarda en un buffer de memoria y despliega la cadena ingresada junto con la cantidad de caracteres procesados.

INCLUDE Irvine32.inc
.data
mensaje BYTE "Escribe tu nombre: ", 0
nombre BYTE 30 DUP(0) ; Buffer de memoria reservado para la cadena de entrada
caracteresEscritos BYTE "Caracteres escritos: ", 0

.code
main PROC

 ; Solicitar entrada al usuario
 mov edx, OFFSET mensaje
 call WriteString

 ; Preparar buffer y longitud máxima de captura
 mov edx, OFFSET nombre
 mov ecx, SIZEOF nombre

 call ReadString ; Lectura desde teclado (retorna longitud en EAX)

 ; Despliegue de la cadena capturada
 mov edx, OFFSET nombre
 call WriteString
 call Crlf
 
 ; Mostrar número total de caracteres introducidos
 mov edx, OFFSET caracteresEscritos
 call WriteString
 call WriteDec

 exit

main ENDP

END main
