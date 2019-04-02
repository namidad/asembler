.code32
SYSEXIT = 1
EXIT_SUCCESS = 0

.data
liczba1:
        .long 0x10304008, 0x701100FF, 0x45100020, 0x08570030
liczba2:
        .long 0xF040500C, 0x00220026, 0x321000CB, 0x04520031

.global _start
_start:

clc

movl $0, %eax
movl $0, %ebx
movl $3, %ecx

odejmowanie:
movl liczba1(,%ecx,4),%eax
movl liczba2(,%ecx,4),%ebx
subl %ebx,%eax
pushl %eax

loop odejmowanie

movl $0, %ecx

movl liczba1(,%ecx,4),%eax
movl liczba2(,%ecx,4),%ebx
subl %ebx,%eax
pushl %eax



end:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

