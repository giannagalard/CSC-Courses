// Gianna Rose
// Lab 10 HW
// https://www.edaplayground.com/x/7uAZ

module differences(D,Clock,Qa,Qb,Qc,Qd, Qe); 

// input data and clock
input D, Clock; 

// output registers
output reg Qa = 0,Qb = 0,Qc = 0,Qd = 0,Qe = 0; 

// JK FF
 reg K = 1; 
initial  
  Qd <= 0; 

//D-Latch
always@(*)
  if(Clock)      
    Qa <= D;

  always @ (posedge Clock) 
begin      
  // rising edge triggered d flip flop  
  Qb <= D; 
if(D)        
  // t flip flop 
  Qd <= ~Qd; 
end   

  // falling edge triggered d flip flop
  always@(negedge Clock) 
Qc <= D;
  
  // JK Flip-Flop
  always@(posedge Clock)
    Qe <= (D & ~Qd) | (~K & Qd);
  
endmodule






