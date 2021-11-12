// AUTHOR : Gianna Rose
// Lab8 Hw 4-bit x 3-bit multiplier
// https://www.edaplayground.com/x/6r2J

module test;
  
  reg [2:0] A;
  reg [3:0] B;
  
  wire [6:0] C;
  
  // Instantiate the Unit Under Test (UUT)
  multiplier uut(C,B,A);  
  
  	initial 
           begin
$dumpfile("dump.vcd");  $dumpvars(1, test);  
	             
                   // display the inputs and outputs
             $monitor( "%d * %d  = %d", A, B, C);


             
       // Initialize Inputs 
//              for(int i = 0; i < 9; i = i + 1) begin
//                for(int j = 0; j < 9; j = j + 1) begin
//                  {B} = j;
//                  #10; 
//                end
//                {A} = i;
//                #10;
//              end
             
             // for loop not working gotta brute :///
                   	A=0; B=0;
                #10 A=1; B=1;
                #10 A=1; B=2;
                #10 A=2; B=2;
             	#10 A=3; B=2;
             	#10 A=4; B=2;
             	#10 A=5; B=2;
             	#10 A=6; B=3;
             	#10 A=7; B=4;
             	#10 A=2; B=7;
             

             
                    #10 $finish;
             end
          endmodule   