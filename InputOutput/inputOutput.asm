section .data
prompt db 'Enter your goals for doing COSC2331 in 80 characters: ', 0xa
len equ $ - prompt              ;length of our string, $ means here
responseMsg dq 'So your goal is: '
response db ''
endOfLine db '!'

section .bss

section .text
global _start

_start:

  mov edx,len    ;third argument (message length)
  mov ecx,prompt    ;second argument (pointer to message to write)
  mov ebx,1      ;load first argument (file handle (stdout))
  mov eax,4      ;system call number (4=sys_write)
  int 0x80       ;call kernel interrupt and exit

  mov eax, 3
  mov ebx, 1
  mov ecx, response
  mov edx, 80
  int 0x80

  mov eax, 4
  mov ebx, 1
  mov ecx, responseMsg
  mov edx, 80
  int 0x80

  mov eax, 1
  mov ebx, 0
  int 0x80
