// Author: Gianna Rose
// Lab 12
// https://www.edaplayground.com/x/mtrR

module ring_counter(clk, reset, stop, direction, Q);
input clk, reset, stop, direction;
output [7:0] Q;

reg [7:0] Qtemp = 8'b00000001; 

 always @(posedge clk) 
    begin 
        if (reset == 1'b1)   
            Qtemp <= 8'b00000001;  
        else if (stop == 1'b1) 
	        Qtemp <= 8'b00000001; 
        else if (direction == 1'b1)
            Qtemp <= {Qtemp[0],Qtemp[7:1]};    //shifting right
        else   
            Qtemp <= {Qtemp[6:0],Qtemp[7]};    //shifting left
    end
assign Q = Qtemp; 

endmodule

module counter(clk, reset, stop, direction, count);
input clk, direction;  // clock, direction for counting up or down       
input reset, stop;   // reset, stop signal

output reg [3:0] count = 0; // output register

always @(posedge clk) 
begin
  if (reset == 1'b1) 
     count <= 0; // reset the counter
  else if (stop == 1'b1)
     count <= count; // do nothing
  else if (direction == 1'b1) 
     count <= count + 1; // count up
  else
     count <= count - 1; // count down
end	

endmodule

module wheeloffortune(clock, reset, stop, direction, LEDs, count);
input clock, reset, stop, direction;
output [7:0] LEDs; 
output [3:0] count;

ring_counter U1(clock, reset, stop, direction, LEDs);  // instantiate the ring counter
counter U2(clock, reset, stop, direction, count);  // instantiate counter
endmodule