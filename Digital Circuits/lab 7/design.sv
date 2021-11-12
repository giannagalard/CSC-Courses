// AUTHOR : GIANNA GALARD 
// LAB 7: INTRO TO VERILOG
// https://www.edaplayground.com/x/Beut

// Code your design here
module multiplier(A0, A1, B0, B1, C0, C1, C2, C3);
   input A0, A1, B0, B1;
   output C0, C1, C2, C3;

  //internal signals (labeled on diagram)
   wire N0, N1, N2, N3;

   //Instantiate the half adders 
  halfadder    HA0 (C3,C2,N0,N1); 
  halfadder    HA1 (C1,N1,N2,N3);
  and A0(N0, A1, B1);
  and A1(N2, A1, B0);
  and A2(N3, A0, B1);
  and A3(C0, A0, B0);

endmodule

module halfadder (S, C, x, y);
   input x, y;
   output S, C;

//Instantiate primitive gates
   xor U1(S, x, y);
   and U2(C, x, y);

endmodule