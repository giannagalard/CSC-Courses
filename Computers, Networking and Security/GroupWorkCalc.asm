
INCLUDE Irvine32.inc


.data
num1			DWORD ?														;First number
num2			DWORD ?														;Second number
op1				DWORD ?														;operator 
opfinal			DWORD ?														;operator final storage
total           DWORD ?														;Total number
intro		BYTE " ------- CSC 220 Calculator (no negatives)-------  ", 0					;Title
start1		BYTE "First number: ", 0										;First number question
start2			BYTE "Second number: ", 0									;Second question number
start3			BYTE "Symbol of Operation: ", 0								;Operator question
equals			BYTE " = ", 0												;equal sign



.code
main PROC
mov eax, 0																	;set registers to 0
mov ebx, 0

		mov		edx, OFFSET intro											;mov the title into eax 
		call	WriteString													;output title
		call	CrLf														;skip line

		mov		edx, OFFSET start1											;mov the first question into eax
		call	WriteString													;output question
		call	ReadInt														;Read user input number into eax
		mov		num1, eax													;Put number into num1

	
		mov		edx, OFFSET start2											;mov the second question into eax	
		call	WriteString													;output question
		call	ReadInt														;Read user input number into eax
		mov		num2, eax													;Put number into num2


		mov		edx, OFFSET start3											;mov the operator question into eax
		call	Writestring													;output question
		call	readchar													;read in user character
		call	writechar													;write out character
		call	CrLf														;skip line
	mov bl, 2Bh																;mov ASCll value of + into bl
	cmp al, bl																;compare value of al to bl
	JNE addfalse															;If not equal skip addition procedure
	JE addnum																;If equal go to addition procedure
	
	addnum:																	;Addition procedure
		mov opfinal, eax													;moving values into eax by adding and then move into total
		mov		eax, num1
		add		eax, num2
		mov		total, eax	
	addfalse:																;skipping 
		cmp al, bl	
	mov bl, 2Dh																;mov ASCll value of - into bl
	cmp al, bl																;compare value of al to bl
	JNE subfalse															;If not equal skip subtraction procedure
	JE subnum																;If equal go to subtraction procedure
		subnum:																;Subraction procedure
		mov opfinal, eax													;moving values into eax by subtracting and then move into total
		mov		eax, num1
		sub		eax, num2
		mov		total, eax
	subfalse:																;skipping 
		cmp al, bl
	mov bl, 2Ah																;mov ASCll value of * into bl
	cmp al, bl																;compare value of al to bl
	JNE mulfalse															;If not equal skip multiply procedure
	JE mulnum																;If equal go to multiply procedure
	mulnum:																	;moving values into eax by multiplying and then move into total
		mov opfinal, eax							
		mov		eax, num1
		mov		ebx, num2
		mul		ebx
		mov		total, eax
	mulfalse:																;skipping
		cmp al, bl
		

		mov		eax, num1													;printing num1
		call	WriteDec
		
		mov ebx, eax
		mov eax, opfinal													;print the operator
		call	WriteChar
	
		mov eax, ebx														;print num2
		mov		eax,  num2
		call	WriteDec

		mov		edx, OFFSET equals											;print equal sign
		call	WriteString

		mov		eax, total													;print total
		call	WriteDec	
		call	CrLf


	exit	
main ENDP

END main
