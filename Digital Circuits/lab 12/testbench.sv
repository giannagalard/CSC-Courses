// Author: Gianna Rose
// Lab 12
// https://www.edaplayground.com/x/mtrR

module test;
reg clock, reset, stop, direction; // input
wire [7:0] LEDs; // output
wire [3:0] count; // output

wheeloffortune uut(clock, reset, stop, direction, LEDs, count); // instantiate the module
     initial
        begin
	    clock = 0; // start the simulation
	    forever  #5 clock = ~clock;  // toggle clock
        #500 $finish;  // stop the simulation
     end 
        
  initial begin
      $dumpfile("dump.vcd"); $dumpvars(1, test); // create a waveform file
      $monitor( "stop= %b, LEDs = %b, count= %b", stop, LEDs, count);  // print the outputs
      
       // Initialize Inputs
         reset = 1;              // reset the circuit
         stop = 0;               // stop the simulation
         direction = 1;          // counting up
         #23  reset = 0;         // disable reset, start counting
         #80  stop = 1;          // pause counting and light movement
         #20  stop = 0;          // resume counting and light movement   
         #20 direction =0;       // change direction of moving lights and couting

         #150 stop = 1;          // pause counting and light movement
         #20  stop = 0;          // resume counting and light movement   
         #50  reset = 1;         // reset the circuit
         #20 $finish;            // stop the simulation
        end 
endmodule

