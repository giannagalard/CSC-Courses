// AUTHOR : GIANNA GALARD 
// LAB 7: INTRO TO VERILOG
// https://www.edaplayground.com/x/Beut

module test;

	reg A0, A1, B0, B1;    // Inputs
	wire C0, C1, C2, C3;       // Outputs

	// Instantiate the Unit Under Test (UUT)
  multiplier uut (A0, A1, B0, B1, C0, C1, C2, C3); 

	initial 
           begin
//the following 2 statements are needed for producing waveform in edaplayground.com
$dumpfile("dump.vcd");  $dumpvars(1, test);  
	             
             // display the inputs and outputs
             $monitor("%b %b %b %b %b %b %b %b", A0, A1, B0, B1, C0, C1, C2, C3);
             // this for loop auto inputs for me woooo 
             for(int i = 0; i < 16; i = i + 1) begin
               {A0, A1, B0, B1} = i;
               #10; // 10 delay units
             end
              #10 $finish;
             
//               0 0 0 0 0 0 0 0
//               0 0 0 1 0 0 0 0
//               0 0 1 0 0 0 0 0
//               0 0 1 1 0 0 0 0
//               0 1 0 0 0 0 0 0
//               0 1 0 1 0 0 0 1
//               0 1 1 0 0 1 0 0
//               0 1 1 1 0 1 0 1
//               1 0 0 0 0 0 0 0
//               1 0 0 1 0 1 0 0
//               1 0 1 0 1 0 0 0
//               1 0 1 1 1 1 0 0
//               1 1 0 0 0 0 0 0
//               1 1 0 1 0 1 0 1
//               1 1 1 0 1 1 0 0
//               1 1 1 1 1 0 1 0

	    end
    endmodule