// design.sv

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

module nine_s_complementer (x,y);
  input [3:0] x;
  output [3:0] y;
  
  // Declare wire
  wire C4;
  
  // Instantiate the nine_s_complementer
  adder_subtractor AS(y, C4, 9, x, 1);
endmodule