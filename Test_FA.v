module Test_FA;

//inputs
reg A, B, Cin, clk, reset;
//outputs
wire S, Cout;

initial begin
  $timeformat(-9, 1, " ns", 6); //set time format to nanoseconds
  $dumpfile ("Test_FA.vcd");
  $dumpvars (0, Test_FA);

  $monitor ("t=%0t, A=%b, B=%b, Cin=%b, S=%b, Cout=%b", $time, A, B, Cin, S, Cout);
 
  //set initial conditions
  clk = 0;
  reset = 1;
  A=0;
  B=0;
  Cin=0;

@(posedge clk);
reset = 0;

//------Test Cases-------

  //test = 0+0+0

  A = 0;
  B = 0;
  Cin = 0;
  @(posedge clk);
  
  //test = 0+1+0

  A = 0;
  B = 1;
  Cin = 0;
   @(posedge clk);
 
  //test 1+0+0
 
  A = 1;
  B = 0;
  Cin = 0;
 @(posedge clk);
  
 
  //test 1+0+1

  A = 1;
  B = 0;
  Cin = 1;
  @(posedge clk);
 
  //test 1+1+1

  A = 1;
  B = 1;
  Cin = 1;
  @(posedge clk);


  @(posedge clk);
  $finish;
end


always begin
  #5 clk <= !clk;
end

FA U0 (
  .clk (clk),
  .reset (reset),
  .A (A),
  .B (B),
  .Cin (Cin),
  .S (S),
  .Cout (Cout)
);

endmodule
