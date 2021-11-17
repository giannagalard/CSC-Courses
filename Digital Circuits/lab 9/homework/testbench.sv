// Author: Gianna Rose
// Lab 9 HW
// https://www.edaplayground.com/x/Bh4i

module test;
  // inputs
  reg [3:0] A, B;
  reg [1:0] operation;
  // outputs
  wire [3:0] result;
  
  // nstantiate the Alu
  Alu uut(A, B, operation, result);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,test);
      
      // display the inputs and outputs
      $monitor( "operation = %b  A =%d  B =%d Result =%d", operation, A, B, result);
      
      // initialize inputs
      operation = 0; A = 3; B = 2;
      for(int i = 0; i < 8; i = i + 1) begin
        #10 operation = i; end
      #10 $finish;
    end
  
  // OUTPUT
// operation = 00  A = 3  B = 2 Result = 5
// operation = 01  A = 3  B = 2 Result = 1
// operation = 10  A = 3  B = 2 Result = 2
// operation = 11  A = 3  B = 2 Result = 3
// operation = 00  A = 3  B = 2 Result = 5
// operation = 01  A = 3  B = 2 Result = 1
// operation = 10  A = 3  B = 2 Result = 2
// operation = 11  A = 3  B = 2 Result = 3
  
  endmodule