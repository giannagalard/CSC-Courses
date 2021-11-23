// Author: Gianna Rose
// Lab 10
// https://www.edaplayground.com/x/NLTd

// module test_SR_latch;
//   reg R, S; 
//   wire Q, Qprime; 
  
//   // module SR_latch (R, S, Q, Qprime);
//   SR_latch uut(R, S, Q, Qprime);
  
//   initial 
//     begin
//       $dumpfile("dump.vcd");
//       $dumpvars(1, test_SR_latch);
      
//       // display the inputs and outputs
//       $monitor("R = %b S = %b Q = %b Q' = %b", S, R, Q, Qprime);
      
//       R = 0; S = 0;
//       #10 R = 0; S = 1;
//       #10 R = 0; S = 0;
//       #10 R = 1; S = 0;
//       #10 R = 1; S = 1;
//       #10 $finish;
      
//     end
// endmodule

// OUTPUT
// R = 0 S = 0 Q = x Q' = x
// R = 1 S = 0 Q = 1 Q' = 0
// R = 0 S = 0 Q = 1 Q' = 0
// R = 0 S = 1 Q = 0 Q' = 1
// R = 1 S = 1 Q = 0 Q' = 0

// --------------------------------------------------

// 	module test_D_Latch;
// 		reg  D, C;
// 		wire Q, Qprime;    

//       // module D_Latch (D, C, Q, Qprime);
//       D_Latch uut(D, C, Q, Qprime);

// 	initial 
//          begin
// 		   $dumpfile("dump.vcd");  
//            $dumpvars(1, test_D_Latch);  
	             
//            // display the inputs and outputs
//            $monitor( "D = %b  C = %b  Q = %b  Q' = %b", D, C, Q, Qprime);

//      	   C=0; D=0;
//            #10 C = 0; D = 1;
//            #10 C = 1; D = 0;
//            #10 C = 0; D = 0;
//            #10 C = 1; D = 1;
//    		  #10 $finish;
           
//          end
//     endmodule
// OUTPUT
// D = 0  C = 0  Q = 0  Q' = x
// D = 1  C = 0  Q = 0  Q' = x
// D = 0  C = 1  Q = 0  Q' = 1
// D = 0  C = 0  Q = 0  Q' = 1
// D = 1  C = 1  Q = 1  Q' = 0

// --------------------------------------------------

//    module testDFF;
// 	reg  Clk, D;   
// 	wire Q, Qprime;   

//      D_ff uut(Clk, D, Q, Qprime);

//    // generate the clock signal
//      initial
//         begin
// 	   Clk = 0;
// 	   forever  #5 Clk = ~Clk; 
//         #200 $finish;  
//        end 

// 	initial 
//          begin
// $dumpfile("dump.vcd");  
// $dumpvars(1, testDFF);  
// 	            // display the inputs and outputs
//            $monitor( "Clk = %b  D = %b  Q = %b  Q' = %b", Clk, D, Q, Qprime);
//       D=0; 
//       #10 D = 1;
//       #10 D = 0;
//       #10 D = 1;
//       #10 D = 0;
//       #10 D = 1;
//       #10 D = 0;

//       #10 $finish;
//     end
// endmodule

// OUTPUT
// Clk = 0  D = 0  Q = x  Q' = x
// Clk = 1  D = 0  Q = 0  Q' = 1
// Clk = 0  D = 1  Q = 0  Q' = 1
// Clk = 1  D = 1  Q = 1  Q' = 0
// Clk = 0  D = 0  Q = 1  Q' = 0
// Clk = 1  D = 0  Q = 0  Q' = 1
// Clk = 0  D = 1  Q = 0  Q' = 1
// Clk = 1  D = 1  Q = 1  Q' = 0
// Clk = 0  D = 0  Q = 1  Q' = 0
// Clk = 1  D = 0  Q = 0  Q' = 1
// Clk = 0  D = 1  Q = 0  Q' = 1
// Clk = 1  D = 1  Q = 1  Q' = 0
// Clk = 0  D = 0  Q = 1  Q' = 0
// Clk = 1  D = 0  Q = 0  Q' = 1
// Clk = 0  D = 0  Q = 0  Q' = 1

// --------------------------------------------------

// module test_Dff_with_synch_reset;
//   reg D, Clk, reset;
//   wire Q, Qprime;
  
//   D_ff_with_synch_reset uut(D, Clk, reset, Q, Qprime);
  
//      initial
//         begin
// 	   Clk = 0;
// 	   forever  #5 Clk = ~Clk; 
//         #200 $finish;  
//        end 

//       initial
//         begin
// 		   $dumpfile("dump.vcd");  
//            $dumpvars(1, test_Dff_with_synch_reset);  
//           $monitor( "D = %b  Clk = %b  reset = %b  Q = %b  Q' = %b", D, Clk, reset, Q, Qprime);
//           D = 0; reset = 0; 
//           #10 D= 1;
//           #10 D=0;
//           #10 D = 1; reset = 1;
//           #10 D = 0;
//           #10 D = 1;
//           #10 D = 0;
//           #10 D = 1; reset = 0;
//           #10	D = 0;
//           #10 $finish;
//          end
// endmodule

// OUTPUT
// D = 0  Clk = 0  reset = 0  Q = 0  Q' = x
// D = 0  Clk = 1  reset = 0  Q = 0  Q' = 1
// D = 1  Clk = 0  reset = 0  Q = 0  Q' = 1
// D = 1  Clk = 1  reset = 0  Q = 1  Q' = 0
// D = 0  Clk = 0  reset = 0  Q = 1  Q' = 0
// D = 0  Clk = 1  reset = 0  Q = 0  Q' = 1
// D = 1  Clk = 0  reset = 1  Q = 0  Q' = 1
// D = 1  Clk = 1  reset = 1  Q = 0  Q' = 1
// D = 0  Clk = 0  reset = 1  Q = 0  Q' = 1
// D = 0  Clk = 1  reset = 1  Q = 0  Q' = 1
// D = 1  Clk = 0  reset = 1  Q = 0  Q' = 1
// D = 1  Clk = 1  reset = 1  Q = 0  Q' = 1
// D = 0  Clk = 0  reset = 1  Q = 0  Q' = 1
// D = 0  Clk = 1  reset = 1  Q = 0  Q' = 1
// D = 1  Clk = 0  reset = 0  Q = 0  Q' = 1
// D = 1  Clk = 1  reset = 0  Q = 1  Q' = 0
// D = 0  Clk = 0  reset = 0  Q = 1  Q' = 0
// D = 0  Clk = 1  reset = 0  Q = 0  Q' = 1
// D = 0  Clk = 0  reset = 0  Q = 0  Q' = 1

