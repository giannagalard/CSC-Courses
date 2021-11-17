// Author: Gianna Rose
// Lab 9 HW
// https://www.edaplayground.com/x/Bh4i

module fulladder (S, C, x, y, cin);
   input x, y, cin;
   output S, C;

   //internal signals 
   wire S1, D1, D2;

   //Instantiate the half adders 
    halfadder    HA1 (S1, D1, x, y); 
    halfadder    HA2 (S, D2, S1, cin);
    or U3(C, D2, D1);

endmodule

module halfadder (S, C, x, y);
   input x, y;
   output S, C;

//Instantiate primitive gates
   xor U1(S, x, y);
   and U2(C, x, y);

endmodule

module four_bit_adder (S, C4, A, B, Cin);
   input [3:0] A,B;
   input Cin;
   output [3:0] S; 
   output C4;
  
  
//Declare intermediate carries
 wire C1, C2, C3;
  
//Instantiate the fulladder 
  fulladder FA0(S[0], C1, A[0], B[0], Cin);
  fulladder FA1(S[1], C2, A[1], B[1], C1);
  fulladder FA2(S[2], C3, A[2], B[2], C2);
  fulladder FA3(S[3], C4, A[3], B[3], C3);
  
endmodule

module adder_subtractor(S, C, A, B, M);
   input [3:0] A,B;
   input M;  
   output [3:0] S;  
   output C;
  
   //Declare outputs of XOR gates
  wire [3:0]N;
  
  // Instantiate the XOR gates
  xor XOR0(N[0],B[0], M);
  xor XOR1(N[1],B[1], M);
  xor XOR2(N[2],B[2], M);
  xor XOR3(N[3],B[3], M);
  
  // Declare carry
  wire C4;
  
  // Instantiate the 4-bit full adder
  four_bit_adder FBA(S, C4, A, N, M);
  
endmodule

module mux4x1(i0, i1, i2, i3, select, y);
   input [3:0] i0,i1,i2,i3;
   input [1:0] select;
   output [3:0] y;
   reg [3:0] y; 
   always @ (i0 or i1 or i2 or i3 or select) 
            case (select)
               2'b00: y = i0;
               2'b01: y = i1;
               2'b10: y = i2;
               2'b11: y = i3;
            endcase
endmodule

module Alu(A, B, operation, result);
  // inputs and outputs
  input [1:0] operation;
  input [3:0] A, B;
  output [3:0] result;
  
  // wires store S and the outputs of AND/OR gates
  wire [3:0] S, AND, OR; 
  wire C4, M;
  
  // instantiate AND gate and OR gate
  assign AND = A & {B[3],B[2],B[1],B[0]};
  assign OR  = A | {B[3],B[2],B[1],B[0]};
  
  // connect M operation[0]
  assign M = operation[0];
  
  // instantiate add_subtractor
  // module adder_subtractor(S, C, A, B, M);
  adder_subtractor AS(S, C4, A, B, M);
  
  // instantiate mux4x1
  // module mux4x1(i0, i1, i2, i3, select, y);
  mux4x1 MUX(S, S, AND, OR, operation, result);
  
  endmodule