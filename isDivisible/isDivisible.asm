SECTION .data

	msg1 db "Yes! It is divisible!",10
	msg1_len equ $ - msg1

	msg2 db "No! It is not divisible!",10
	msg2_len equ $ - msg2

	num1 db 125
	num2 db 6

SECTION .text

	global _start			;Start


	_start:				;Start

	push dword [num1]		;Push num1
	push dword [num2]		;Push num2
	call isDivisible		;Check if isDivisible


	jmp exit			;exit

;--------SUBROUTINES-----------------------------------------------------------
writeString:

	push ebp
	mov ebp, esp
	pushad				;Push all 32 Bit Registers to save values.

	mov eax, 4			;SYSWRITE
	mov ebx, 1			;STDOUT
	mov ecx, [ebp+12]		;Set to output string
	mov edx, [ebp+8]		;Length of the output
	int 80h				;Interrupt

  popad	;Pop all 32 Bit Registers to Original Values.
	pop ebp	;Reset stack
	ret 8	;Return


isDivisible:				;int isDivisible(int number 1, int number 2)

	push ebp			;Save ebp
	mov ebp, esp			;setup stack frame

	xor eax, eax			;Zero eax
	push ebx			;Save registers
	push ecx
	push edx


	mov eax, [ebp + 12]
	mov ebx, [ebp + 8]

	div ebx

	cmp edx, 0			;if remainder == 0 goto numIsDivisible
	je numIsDivisible

	call numIsNotDivisible ;otherwise goto numIsNotDivisible



numIsDivisible:
  pop edx				;Reset registers
  pop ecx
  pop ebx

  pop ebp				;Reset stack

	push msg1
	push msg1_len
	call writeString

	jmp exit			;Exit

numIsNotDivisible:
  pop edx				;Reset registers
  pop ecx
  pop ebx

  pop ebp				;Reset stack

	push msg2
	push msg2_len
	call writeString

	jmp exit			;Exit




exit:
	mov ebx, 0	;Status
	mov eax, 1	;SysExit
	int 80h	;Exit
