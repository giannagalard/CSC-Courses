// question 1

@ a)
@ For the following C statement, write the corresponding LEGv8 assembly code. 
@ Assume that the C variables f, g, and h, have already been placed in registers X3, X4, and X5 respectively. 
@ Use a minimal number of LEGv8 assembly instructions. 
@       f = g - (h + 5);

    // add h + 5 to f
    ADDI X5, X5, #5 
    // subtract g from (h+5) to f
    SUB X3, X5, X4

@ b)  
@ For the following C statement, write a minimal sequence of LEGv8 assembly instructions that performs the identical operation. 
@ Assume d is in X2, and X3 is the base address of the array A.
@       d = A[5] >> 3;

    // load offset 8*5=40 
    LDUR X9, [X3, #40] // X9 = A[5]
    LSR X2, X9, #3 // d = A[5] >> 3


// question 2

@ a)
@ For the following C statement, write the corresponding LEGv8 assembly code. 
@ Assume that the variables f, g, h, i, and j are assigned to registers X0, X1, X2, X3, and X4, respectively. 
@ Assume that the base address of the arrays A and B are in registers X6 and X7, respectively.
@         A[i-j] = B[4];

    // load B[4]
    // use x7 so that it will load w/e is in base address of B + offset of 32
    LDUR X7, [X7, #32] // X7 = B[4]
    // [i-j]]
    SUB X9, X3, X4 // X9 = i - j
    // offset of 8*(i-j)
    LSL X9, X9, #3 // X9 = 8*(i-j)
    // set address of A[i-j]
    ADD X9, X9, X6 // X9 = base address of A + offset of 8*(i-j)
    // store B[4]
    STUR X7, [X9, #0] // A[i-j] = B[4]


@ b)
@  For the following C statement, write the corresponding LEGv8 assembly code. 
@  Assume that the variables f, g, h, i, and j are assigned to registers X0, X1, X2, X3, and X4, respectively. 
@  Assume that the base address of the arrays A and B are in registers X6 and X7, respectively.
@         A[i] = A[j] + B[3];

    // load B[3]
    // use x7 so that it will load w/e is in base address of B + offset of 24
    LDUR X7, [X7, #24] // X7 = B[3]
    // offset of 8*j
    LSL X9, X4, #3 // X9 = 8*j
    // add base address of A to offset of 8*j
    ADD X9, X9, X6 // X9 = base address of A + offset of 8*j
    // load with offset #0
    LDUR X10, [X9, #0] // X10 = A[j]
    // add B[3] to A[j]
    ADD X10, X10, X7 // X10 = A[j] + B[3]
    // offset address of A[i]
    LSL X9, X3, #3 // X9 = 8*i
    // add base address of A to offset of 8*i
    ADD X9, X9, X6 // X9 = base address of A + offset of 8*i
    // store A[i]
    STUR X10, [X9, #0] // A[i] = A[j] + B[3]


// question 3
@ a) How many locations of memory (in terms of the number of bytes) can you address with 17-bit memory address?   
    @ - 2^17 = 131072 locations
@ b)
@ How many bits are required to address a 64-Mega-location memory, i.e, what should the number of bits of the memory address be in order to access a 64MB memory? 
    @ - 64MB = 64*1024*1024 = 67108864 bytes
@ c)
@ Assume A is an integer array with 20 elements stored in memory and its starting memory address is in X3. What is the memory address for element A[5]?
    @ - A[5] = X3 + 8*5 = X3 + 40
@ d)
@ Assume C is a character array with 20 elements stored in memory and its starting memory address is in X4. What is the memory address for element C[12]?
    @ - C[12] = X4 + 12
@ e)
@ Write at least five different ways to assign 0 to register X3.
    ADDI X3, XZR, #0 // 0 + 0
    SUBI X3, XZR, #0 // 0 - 0
    ANDI X3, XZR, #1 // 0 and 1 = 0
    EORI X3, XZR, #0 // 0 xor 0 = 0
    MOV X3, XZR // X3 = 0


// question 4
@ a)
@ Follow the instructions below CONSECUTIVELY, and after each instruction write the value of destination register in decimal into the space provided.
    ORRI X0, X31, #5  // X0 = 5
    SUBI X1, X0, #2   // X1 = 3
    LSL X2, X1, #2    // X2 = 6
    ADD X3, X2, X2    // X3 = 12
    ANDI X4, X3, #13  // X4 = 12
@ b)
@ For the following LEG8 assembly, assume that the registers X1 and X6, contain the values 20 and 256, respectively. 
@ Also, assume that memory contains the following values. What is the value of X0?
    SUBI X6, X6, #20  // X6 = 256 - 20 = 236
    ADD X6, X6, X1    // X6 = 236 + 20 = 256
    LDUR X0, [X6, #8] // X0 = memory[256+8] = memory[264] = 150


