// Author: Gianna Rose
// Lab 11
// https://www.edaplayground.com/x/eypm

module test;
  reg clock, x, reset;
  wire y;
  wire [1:0] state;

  // instantiate the uut
  sequence_detector uut(clock, reset, x, y, state); 
  
  //generating the clock signal
  initial
    begin 
      clock = 0; // clock starts low
      forever #5 clock = ~clock; // toggle clock
      #200 $finish; // stop simulation after 200 clock cycles
    end 
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars(1,test);
      // monitor the state, x, and y signals
      $monitor("state = %b x = %b y = %b ", state,x,y); 
      
      // Initalize inputs
      
      x = 0; reset = 1;
      
      #13  reset = 0; // hold reset low for 13 clock cycles
      #10   x = 1; // set x high for 10 clock cycles
      #10   x = 0; // set x low for 10 clock cycles
      #10   x = 1; 
      #10   x = 1;
      #10   x = 0; 
      #10   x = 1; 
      #10   x = 0; 
      #10   x = 0; 
      #10   x = 1; 
      #10   x = 1; 
      #10   x = 1; 
      #10   x = 0; 
      #10   x = 0;
      #10 $finish;  // stop simulation after 200 clock cycles          
    end 
endmodule

//  OUTPUT
// state = 00 x = 0 y = 0 
// state = 00 x = 1 y = 0 
// state = 01 x = 1 y = 0 
// state = 01 x = 0 y = 0 
// state = 00 x = 0 y = 0 
// state = 00 x = 1 y = 0 
// state = 01 x = 1 y = 0 
// state = 10 x = 1 y = 0 
// state = 10 x = 0 y = 0 
// state = 11 x = 0 y = 1 
// state = 11 x = 1 y = 1 
// state = 01 x = 1 y = 0 
// state = 01 x = 0 y = 0 
// state = 00 x = 0 y = 0 
// state = 00 x = 1 y = 0 
// state = 01 x = 1 y = 0 
// state = 10 x = 1 y = 0 
// state = 10 x = 0 y = 0 
// state = 11 x = 0 y = 1 
// state = 00 x = 0 y = 0 