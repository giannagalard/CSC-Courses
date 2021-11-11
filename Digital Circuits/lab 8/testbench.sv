// testbench.sv

// Author: Gianna Rose
// Lab 8: 9’s Complementer
// https://www.edaplayground.com/x/NPSc

module test;
  // input
  reg[3:0] x; 
  // output
  wire[3:0] y;   

  // Instantiate the Unit Under Test (UUT)
  nine_s_complementer uut(x,y);  

	initial 
           begin
$dumpfile("dump.vcd");  $dumpvars(1, test);  
	             
                   // display the inputs and outputs
             $monitor( "x = %d  y = %d", x, y);


       // Initialize Inputs
             for(int i = 0; i < 10; i = i + 1) begin
               {x} = i;
               #10;
             end
             
                    #10 $finish;
             end
          endmodule   