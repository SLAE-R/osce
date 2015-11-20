#include "syscall.h"
#include "traps.h"
#include "asm.h"

.globl EXIT_BEGIN
EXIT_BEGIN:
  	pushl %eax
  	pushl %eax
    movl $SYS_exit, %eax
    int $T_SYSCALL
    ret
