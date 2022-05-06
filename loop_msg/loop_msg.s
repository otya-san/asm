global _start
%define SYS_WRITE (0x0001)
%define SYS_EXIT  (0x003C)
%define STD_WRITE (0x0001)
%define MAX_CNT   (0x000A)

[section .data]
  msg: db 'Hello, World!', 0x000A, 0x0000
  len: equ $-msg

[section .text]
_start:
  mov rcx, 0x0000

_loop:
  call .print_msg
  
  inc rcx
  cmp rcx, MAX_CNT
  jb _loop

  call .exit

.print_msg:
  mov rax, SYS_WRITE 
  mov rdi, STD_WRITE
  mov rsi, msg
  mov rdx, len

  push rcx
  syscall
  pop rcx
  ret

.exit:
  mov rax, SYS_EXIT
  xor rdi, rdi
  syscall
