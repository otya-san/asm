global _start
%define SYS_WRITE (0x0001)
%define SYS_EXIT  (0x003C)
%define STD_WRITE (0x0001)

[section .data]
  newline: db 0x000A

[section .text]
_start:
  mov rcx, 0x0021

.loop:
  call .print_ascii
  call .print_newline

  inc rcx
  cmp rcx, 0x007F
  jb .loop

  call .exit

.print_ascii:
  push rcx
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  lea rsi, [rsp]
  mov rdx, 0x0001
  
  syscall
  pop rcx
  ret

.print_newline:
  mov rax, SYS_WRITE
  mov rdi, STD_WRITE
  mov rsi, newline
  mov rdx, 0x0001
  
  push rcx
  syscall
  pop rcx
  ret

.exit:
  mov rax, SYS_EXIT
  xor rdi, rdi
  syscall
