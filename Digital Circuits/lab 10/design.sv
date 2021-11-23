// Author: Gianna Rose
// Lab 10
// https://www.edaplayground.com/x/NLTd

module SR_latch (R, S, Q, Qprime);
input R, S;
output Q, Qprime;
nor n0(Q,R,Qprime);
nor n1(Qprime,S,Q);

endmodule

module D_Latch (D, C, Q, Qprime);
  input D, C;
  output Q, Qprime;
  reg Q = 0, Qprime;
  
  always @ (D or C)
    begin
      if (C) begin
        Q <= D;
      Qprime <= ~D;
      end
    end
endmodule

module D_ff (Clk, D, Q, Qprime);
  input Clk, D;
  output reg Q, Qprime;
  
  always @ (posedge Clk)
      begin
 		Q <= D;
        Qprime <= ~D;
      end
endmodule
  

module D_ff_with_synch_reset (D, Clk, reset, Q, Qprime);
         input D, Clk, reset;
         output Q, Qprime;
         reg Q =0, Qprime;

always @(posedge Clk)
if (reset)
                                            begin
Q <= 1'b0;
Qprime <= 1'b1; 
                                             end
 else
      begin
Q <= D;
  	Qprime <= ~D;
      end
         endmodule
