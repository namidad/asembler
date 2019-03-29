SYSEXIT = 1
EXIT_SUCCESS = 0
SYSWRITE = 4
STDOUT = 1
SYSREAD = 3
STDIN = 0

.data
buf: .ascii "     "
buf_len = . - buf

.text
msg: .ascii "Podaj slowo porownane z Hello \n"
msg_len = . - msg
msg2: .ascii "Zgadza sie \n"
msg2_len = . - msg2
msg3: .ascii "Nie zgadza sie \n"
msg3_len = . - msg3
msg4: .ascii "Hello"
msg4_len = . - msg4


.global _start
_start:

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov $msg_len, %edx
int $0x80

mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $buf, %ecx
mov $buf_len, %edx
int $0x80

mov $0, %edx
loop:
mov buf(,%edx,1), %al
mov msg4(,%edx,1), %bl
cmp %al, %bl
jne nieprawda
inc %edx
cmp $msg4_len,%edx
jz prawda
jmp loop


nieprawda:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg3, %ecx
mov $msg3_len, %edx
int $0x80
jmp koniec

prawda:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg2, %ecx
mov $msg2_len, %edx
int $0x80

koniec:
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
