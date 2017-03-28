;Assembly language program to find sum   SUMPROG.ASM
;
;         Objective: To add two integers.
;            Inputs: Two integers.
;            Output: Sum of input numbers.
%include  "io.mac"

.DATA
prompt1_msg  db  'Enter first number: ',0
prompt2_msg  db  'Enter second number: ',0
sum_msg      db  'Sum is: ',0
error_msg    db  'Overflow has occurred!',0
 
.UDATA
number1      resd  1        ; stores first number
number2      resd  1        ; stores first number
sum          resd  1        ; stores sum
 
.CODE
      .STARTUP
      ; prompt user for first number
      PutStr  prompt1_msg
      GetLInt [number1]
      
      ; prompt user for second number
      PutStr  prompt2_msg
      GetLInt [number2]
      
      ; find sum of two 32-bit numbers
      mov     EAX,[number1]
      add     EAX,[number2]
      mov     [sum],EAX
       
      ; check for overflow
      jno     no_overflow
      PutStr  error_msg
      nwln
      jmp     imprimir_segmento
 
      ; display sum
no_overflow:
      PutStr  sum_msg
      PutLInt [sum]
      nwln
      
imprimir_segmento:
     mov EDX, 0					 ; Usa EDX como contador de bytes
	 mov EBX, prompt1_msg        ; Carga EBX con el inicio del segmento
	 mov AL, [EBX]				 ; Carga AL con los primeros 8 bits
	 mov ECX, 8					 ; Usa ECX como contador de bits
ciclo_bits:
	 cmp ECX,0					 ; Verifica si ya imprio 8 bits
	 je ciclo_bytes				 ; Pasa de ciclo de bytes si es cierto
	 shl AL,1					 ; Sino pasa el siguiente bit al CF
	 jc bit_1                    ; Verifica si es 1
bit_0:
	 PutCh '0'                   ; Si no es 1 imprime 0
	 dec ECX                     ; Decrementa contador de bits
	 jmp ciclo_bits              ; Repite ciclo de bits
bit_1:
	 PutCh '1'					 ; Si es 1 imprime 1
	 dec ECX					 ; Decrementa contador de bits
	 jmp ciclo_bits              ; Repite ciclo de bits
ciclo_bytes:
	 PutCh 20h                   ; Imprime espacio  
	 inc EDX                     ; Incrementa contador de bytes
	 cmp EDX, 83                 ; Compara contador con tamano del seg-
								 ; mento de datos en bytes (menos 1)
								 
	 jg fin                      ; Termina programa si contador es mayor
	 inc EBX                     ; Sino, suma 1 byte a la direccion an-
								 ; anterior
								 
 	 mov ECX,8                   ; Resetea contador de bits
	 mov AL, [EBX]               ; Carga AL con siguientes 8 bits
	 jmp ciclo_bits              ; Repite ciclo de bytes
fin:
      .EXIT
