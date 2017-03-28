;An example assembly language program               SAMPLE.ASM
;
;         Objective: To demonstrate the use of some I/O
;                    routines and to show the structure
;                    of assembly language programs.
;            Inputs: As prompted.
;           Outputs: As per input.
%include  "io.mac"

.DATA
name_msg      db   'Please enter your name: ',0
query_msg     db   'How many times to repeat welcome message? ',0
confirm_msg1  db   'Repeat welcome message ',0
confirm_msg2  db   ' times? (y/n) ',0 
welcome_msg   db   'Welcome to Assembly Language Programming ',0

.UDATA
user_name    	resb  16             ; buffer for user name
response     	resb  1

.CODE
     .STARTUP
     PutStr  name_msg            ; prompt user for his/her name
     GetStr  user_name,16        ; read name (max. 15 characters)
ask_count:
     PutStr  query_msg           ; prompt for repeat count
     GetInt  CX                  ; read repeat count
     PutStr  confirm_msg1        ; confirm repeat count
     PutInt  CX                  ; by displaying its value
     PutStr  confirm_msg2
     GetCh   [response]          ; read user response
     cmp     byte [response],'y' ; if 'y', display welcome message
     jne     ask_count           ; otherwise, request repeat count
display_msg:
     PutStr  welcome_msg         ; display welcome message
     PutStr  user_name           ; display the user name
     nwln
     loop    display_msg         ; repeat count times
imprimir_segmento:
     mov EDX, 0					 ; Usa EDX como contador de bytes
	 mov EBX, name_msg           ; Carga EBX con el inicio del segmento
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
	 cmp EDX, 165                ; Compara contador con tamano del seg-
								 ; mento de datos en bytes (menos 1)
								 
	 jg fin                      ; Termina programa si contador es mayor
	 inc EBX                     ; Sino, suma 1 byte a la direccion an-
								 ; anterior
								 
 	 mov ECX,8                   ; Resetea contador de bits
	 mov AL, [EBX]               ; Carga AL con siguientes 8 bits
	 jmp ciclo_bits              ; Repite ciclo de bytes
fin:
     .EXIT