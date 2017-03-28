;Adds a set of integers                      ADDITION.ASM
;
;        Objective: To find the sum of a set of integers. 
;            Input: Requests integers from the user.
;           Output: Outputs the sum of the input numbers.
%include  "io.mac"
	
.DATA
input_prompt   db   "Please enter at most 10 numbers: ",0
end_msg        db   "No more numbers? Enter 0 to end: ",0
sum_msg        db   "The sum is: ",0
overflow_msg   db   "Ha ocurrido un overflow, intentar otra vez? (S|N):",0

.UDATA
respuesta	   resb 1 

.CODE
     .STARTUP
inicio:
     PutStr  input_prompt  ; prompt for input numbers
     mov     ECX,10        ; loop count = 10
     sub     EAX,EAX       ; sum = 0

read_loop:
     GetLInt EDX           ; read the input number 
     cmp     EDX,0         ; is it zero?
     je      reading_done  ; if yes, stop reading input         
     add     EAX,EDX
     jo		 error_overflow
     cmp     ECX,1         ; if 10 numbers are input 
     je      skip_msg      ; skip displaying end_msg 
     PutStr  end_msg
skip_msg:
     loop    read_loop
error_overflow:
	 PutStr overflow_msg
	 GetCh [respuesta]
	 cmp byte [respuesta],'S'
	 je inicio

reading_done:
     PutStr  sum_msg
     PutLInt EAX           ; write the sum
     nwln
     .EXIT
