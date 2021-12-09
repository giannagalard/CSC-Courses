// Author: Gianna Rose
// Lab 11 hw
// https://www.edaplayground.com/x/9Bn4

module test;
  reg clock, x, reset;
  wire y;
  wire [1:0] state;
  
  sequence_detector uut(clock, reset, x, y, state);
  
  //generating the clock signal
  initial
    begin
      clock = 0;
      forever #5 clock = ~clock;
      #200 $finish;
    end
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars(1,test);
      $monitor("state = %b x = %b y = %b ", state,x,y);
      
      // Initalize inputs
      
      x = 0; reset = 1;
      
      #13  reset = 0;
      #10   x = 1; 
      #10   x = 0; 
      #10   x = 1; 
      #10   x = 1;
      #10   x = 0; 
      #10   x = 1; 
      #10   x = 0; 
      #10   x = 0; 
      #10   x = 1; 
      #10   x = 1; 
      #10   x = 0; 
      #10   x = 0; 
      #10   x = 1;
      #10   x = 0;
      #10 $finish;              
    end
endmodule