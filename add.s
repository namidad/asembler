.code32
SYSEXIT = 1
EXIT_SUCCESS = 0

.data
liczba1:
        .long 0x10304008, 0x701100FF, 0x45100020, 0xF8570030
liczba2:
        .long 0xF040500C, 0x00220026, 0x321000CB, 0x14520031

.global _start
_start:

clc

movl $0, %eax
movl $0, %ebx
movl $3, %ecx

dodawanie:
movl liczba1(,%ecx,4),%eax
movl liczba2(,%ecx,4),%ebx
adcl %eax,%ebx
pushl %ebx

loop dodawanie

movl $0, %ecx

movl liczba1(,%ecx,4),%eax
movl liczba2(,%ecx,4),%ebx
adcl %eax,%ebx
pushl %ebx

jc carry_flag

jmp end

carry_flag:
movl $1, %ebx
pushl %ebx


end:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

