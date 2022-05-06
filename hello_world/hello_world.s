global _start
%define SYS_WRITE (0x0001)
%define SYS_EXIT  (0x003C)
%define STD_WRITE (0x0001)

[section .data]
  msg: db 'Hello, World!', 0x000A, 0x0000
  len: equ $-msg

[section .text]
_start:
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  mov rsi, msg
  mov rdx, len
  syscall

  mov rax, SYS_EXIT
  xor rdi, rdi
  syscall
