// Author : Gianna Rose
// Lab 9 
// https://www.edaplayground.com/x/BsXs

module Alu(A,B,operation,result);
  input [3:0] A,B;
  input [2:0] operation;
  output [3:0] result;
  reg [3:0] result; // redeclare the signals that appear on the left-hand side of the 
  					// assignment statements inside the always block
  always @(A,B,operation)
    begin
      case(operation)
        3'b000: result = A & B;
        3'b001: result = A | B;
        3'b010: result = ~B; //  bit-wise operator and returns the invert of the argument
        					// use ! for if true or false of single bit
        3'b011: result = A << B;
        3'b100: result = A + B;
        3'b101: result = A - B;
        3'b110: result = A * B;
        3'b111: result = A / B;
      endcase
    end
endmodule

module bin7seg(x,seg,dp);
  // 4-bit input display
  input[3:0] x;
  // segments from a to g
  output[6:0] seg;
  // decimal point
  output dp;
  // redeclare as the type of reg
  reg [6:0] seg;
  
  always@(x)
    case(x)
      0: seg = 7'b0000001;
      1: seg = 7'b1001111;
      2: seg = 7'b0010010;
      3: seg = 7'b0000110;
      4: seg = 7'b1001100;
      5: seg = 7'b0100100;
      6: seg = 7'b0100000;
      7: seg = 7'b0001111;
      8: seg = 7'b0000000;
      9: seg = 7'b0000100;
      10: seg = 7'b0001000;
      11: seg = 7'b1100000;
      12: seg = 7'b0110001;
      13: seg = 7'b1000010;
      14: seg = 7'b0110000;
      15: seg = 7'b0111000;
      default: seg = 7'b1111110;  
    endcase
endmodule

module toplevelmodule(A,B,operation, seg, dp);
// result and x get tied together internally , make it a wire
  input [3:0] A, B;
  input [2:0] operation;
  wire [3:0] result;
  output [6:0] seg;
  output dp;
 
  // turn off decimal point 
  // active low -> 1 not 0
  assign dp = 1;
  
  // instantiate the ALU
  // module Alu(A,B,operation,result);
  Alu ALU(A, B, operation, result);
  
  // instantiate the 7-seg display decoder
  // module bin7seg(x,seg,dp);
  bin7seg bin7seg(result,seg,dp);
endmodule