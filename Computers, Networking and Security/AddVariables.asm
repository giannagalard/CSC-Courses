; this program calculates the sum of 3 64-bit integers

INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
val1 qword 1111000000001100h
val2 qword 222211110000000011h
val3 qword 3333222200001111h
sum qword 0

.code
main PROC
mov rax, val1
add rax, val2
add rax, val3
mov sum, rax

INVOKE ExitProcess,0
main endp
end main
