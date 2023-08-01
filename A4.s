.global _start

.equ amark, 90
.equ bmark, 75
.equ cmark, 50

_start:

    LDR R6, =amark //Load the value at the memory address  'amark' into R6
    LDR R7, =bmark
    LDR R8, =cmark

    LDR R1, =amessage
    LDR R2, =alen
    MOV R7, #4
    SWI 0

.data
amessege:
    .asciz "Congratulations, you got an A .\n"
alen = .-amessage