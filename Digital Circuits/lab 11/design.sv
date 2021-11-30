// Author: Gianna Rose
// Lab 11
// https://www.edaplayground.com/x/eypm

module sequence_detector(clock, reset, x, y, state); 
     // input
     input clock, reset, x; 
     // output
     output y; 
     output [1:0] state; // state is 2-bit
     reg [1:0] state; 

   always @( posedge clock, posedge reset ) // state machine
       if (reset) 
         state <= 2'b00; // reset state
   else
       case (state)
         2'b00: if(x)state <= 2'b01;   else state <= 2'b00; 
         2'b01: if(x)state <= 2'b10;   else state <= 2'b00; 
         2'b10: if(x)state <= 2'b10;   else state <= 2'b11; 
         2'b11: if(x)state <= 2'b01;   else state <= 2'b00;
       endcase

  // output y at state “11”
  assign  y = state[1] & state[0]; // state[1] is the MSB
endmodule

