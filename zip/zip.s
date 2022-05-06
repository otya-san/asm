global _start
%define SYS_WRITE (0x0001)
%define SYS_EXIT  (0x003C)
%define STD_WRITE (0x0001)

[section .data]
  strings: db 'ABCDEFGHIJ'
  numbers: db '0123456789'
  newline: db 0x000A

[section .text]
_start:
  mov rcx, 0x0000

.loop:
  call .print_strings
  call .print_numbers

  inc rcx
  cmp rcx, 0x000A
  jb .loop

  call .print_newline
  call .exit

.print_strings:
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  lea rsi, [strings+rcx]
  mov rdx, 0x0001

  push rcx
  syscall
  pop rcx
  ret

.print_numbers:
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  lea rsi, [numbers+rcx]
  mov rdx, 0x0001

  push rcx
  syscall
  pop rcx
  ret

.print_newline:
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  mov rsi, newline
  mov rdx, 0x0001
  syscall
  ret

.exit:
  mov rax, SYS_EXIT
  xor rdi, rdi
  syscall
