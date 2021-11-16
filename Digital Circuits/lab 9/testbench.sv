// Author : Gianna Rose
// Lab 9 
// https://www.edaplayground.com/x/BsXs

module test;
  // inputs
  reg [3:0] A,B;
  reg [2:0] operation;
  // outputs
  wire [3:0] result;
  wire [6:0] seg;
  wire dp;
  
  // instantiate the ALU
  Alu uut0(A, B, operation, result);
  
  // instantiate toplevelmodule
  toplevelmodule uut1(A,B,operation, seg, dp);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,test);
      
      // display the inputs and outputs
      $monitor("operation = %b A = %d B = %d  Result = %d seg = %b", operation, A,B, result, seg);
               
      // initialize inputs
      operation = 0; A = 3; B = 2;
      for(int i = 0; i < 8; i = i + 1) begin
        #10 operation = i; end
      #10 $finish;
    end

// OUTPUT
// operation = 000 A =  3 B =  2  Result =  2 seg = 0010010
// operation = 001 A =  3 B =  2  Result =  3 seg = 0000110
// operation = 010 A =  3 B =  2  Result = 13 seg = 1000010
// operation = 011 A =  3 B =  2  Result = 12 seg = 0110001
// operation = 100 A =  3 B =  2  Result =  5 seg = 0100100
// operation = 101 A =  3 B =  2  Result =  1 seg = 1001111
// operation = 110 A =  3 B =  2  Result =  6 seg = 0100000
// operation = 111 A =  3 B =  2  Result =  1 seg = 1001111
  
endmodule