// Author: Gianna Rose
// Lab 11 hw
// https://www.edaplayground.com/x/9Bn4

module sequence_detector(clock, reset, x, y, state);
  input clock, reset, x;
  output reg y = 0;
  output reg [1:0] state;
  
  always @(posedge clock, posedge reset)
    if(reset)
      state <= 2'b00;
  else
    case(state)
      2'b00: if(x)begin
        state <= 2'b00; 
        assign y = 0;
        end
      else 
        begin
        state <= 2'b01;
          assign y = 0;
      end
      2'b01: if(x) 
        begin
          state <= 2'b00;
          assign y = 0;
          end
      else 
        begin
        state <= 2'b10;
        assign y = 0;
      end
      2'b10: if(x) 
        begin
          state <= 2'b00; 
          assign y = 1;
        end
          else 
            begin
            state <= 2'b10;
			assign y = 0;
            end
        endcase
  
endmodule