.global _start

.equ amark, 90     // A grade threshold
.equ bmark, 75     // B grade threshold
.equ cmark, 50     // C grade threshold

_start:

    // Load grade thresholds
    LDR R6, =amark  
    LDR R7, =bmark  
    LDR R8, =cmark  

input_loop:
    // Print prompt
    LDR R1, =prompt 
    LDR R2, =plen   
    MOV R7, #4      
    SWI #0          

    // Read user input
    MOV R7, #3      
    LDR R1, =buffer 
    MOV R2, #3      // Expect up to 3 digits for the percentage grade
    SWI #0          

    // Load grade from buffer
    LDR R5, [R1]    

    // Compare grade with thresholds and branch accordingly
    CMP R5, R6      
    BGE agrade      

    CMP R5, R7      
    BGE bgrade      

    CMP R5, R8      
    BGE cgrade      

    // Grade didn't meet any threshold, print F message
    LDR R1, =fmessage
    LDR R2, =flen
    MOV R7, #4      
    SWI #0          
    B input_loop    

agrade:
    // Print A grade message
    LDR R1, =amessage
    LDR R2, =alen
    MOV R7, #4      
    SWI #0          
    B input_loop    

bgrade:
    // Print B grade message
    LDR R1, =bmessage
    LDR R2, =b_len  
    MOV R7, #4      
    SWI #0          
    B input_loop    

cgrade:
    // Print C grade message
    LDR R1, =cmessage
    LDR R2, =clen
    MOV R7, #4      
    SWI #0          
    B input_loop    

end:
    // Exit the program
    MOV R7, #1      
    MOV R0, #0      
    SWI #0          

.data
// Define prompt and grade messages
prompt:
    .asciz "Enter percentage grade (0-100): "
plen = . - prompt   

buffer:
    .space 3        // Reserve 3 bytes for input buffer (0-100)

amessage:
    .asciz "You got an A. Excellent work!\n"
alen = . - amessage 

bmessage:
    .asciz "You got a B. Good job!\n"
b_len = . - bmessage 

cmessage:
    .asciz "You got a C. Keep working on it!\n"
clen = . - cmessage 

fmessage:
    .asciz "You got an F. You can do better next time!\n"
flen = . - fmessage 
