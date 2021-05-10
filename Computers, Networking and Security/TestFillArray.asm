

; this program fills the array with N random integers that  are within a given range

INCLUDE Irvine 32.inc

.data
msg1 BYTE “Elements of the array that contains “
     BYTE “ the elements in the range -20...30 :”,0
msg2 BYTE “Elements of the array that contains “
     BYTE “ the elements in the range 100...200 :”,0
N=5
darray DWORD N DUP(?)      ; dword array holds n integers

.code
main PROC ; calls the procedure
call Clrscr   ; clears the screen
; call fill array to fill the array with 5 random integers 
; that are in the range -20 to 30
mov esi, OFFSET darray   ; pass the address of array
mov ecx, N               ; pass N
mov ebx, -20          ; pass the value of j (lower limit)
mov edx, 30           ; pass the value of k (upper limit)
call fillArray        ; call the procedure SumArray
; display the elements of the array
mov edx, OFFSET msg1
call WriteString
call Crlf
L2: 
mov eax,[esi]
call WriteInt
call Crlf
add esi, 4
loop l2
; call fillArray to fill the array with 5 random integers 
; that are in the range 100 to 200
mov esi, OFFSET darray     ; pass the address of array
mov ecx, N                 ; pass N
mov ebx, 100           ; pass the value of j (lower limit)
mov edx, 200           ; pass the value of k (upper limit)
call fillArray         ; call the procedure SumArray
; display the elements of the array
mov edx, OFFSET msg2
call WriteString
call Crlf
L3:
mov eax,[esi]
call WriteInt
call Crlf
add esi, 4
loop L3

call Crlf
exit
main ENDP

; fillArray fills the array with elements that are in given range
; receives: esi-pointer to the dword array
; ecx=value of N, EBX=value of j, EDX=value of k
; Returns: Nothing

fillArray PROC USES ecx esi eax ebx ecx edx
; call randomize to get unique values each time
call randomize
add edx, 1           ; edx=k+1
L1:
mov eax, edx         ; mov k+1 to eax
sub eax, ebx         ; eax=(k+1)-j
call RandomRange     ; generate a random int between 0 -   
                     ;                            (eax-1)
; eax = a random integer in the range {0,(k-j)} 
; convert the random int return by RandomRange into an int
; that is in the range {j,k} by adding j to eax
add eax, ebx         ; eax=eax+ebx
mov[esi],eax         ; fill the array with gen rand int
add esi, 4           ; increment the pointer of the array 
                     ; to point the next int location
loop L1
fillArray ENDP
END main

