// Gianna Rose
// Lab 10 HW
// https://www.edaplayground.com/x/7uAZ


   module testAll;
    // Clock and D inputs
    reg  Clock, D; 
    // Qa-Qe are the outputs 
	wire Qa, Qb, Qc, Qd, Qe; 


     
     // instantiate the UUT
     differences uut(D, Clock, Qa, Qb, Qc, Qd, Qe); 
     
    // generate the clock signal
     initial
        begin
	   Clock = 0;
	   forever  #5 Clock = ~Clock; 
        #200 $finish;  
       end 

	initial 
         begin
$dumpfile("dump.vcd");  
    $dumpvars(1, testAll);  
           
         D=0;
      #4 D=1;
      #2 D=0;
      #1 D=1;
      #1 D=0;
      #3 D=1;
      #1 D=0;
      #1 D=1;
      #1 D=0;
      #2 D=1;
      #1 D=0;
      #2 D=1;
      #2 D=0;
      #10 $finish;

    end
        endmodule


