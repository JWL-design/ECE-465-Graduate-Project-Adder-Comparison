`timescale 1ns/1ps

module Test_CLA_4;

//inputs
reg clk;
reg reset;
reg [3:0] A;
reg [3:0] B;
reg Cin;
//outputs
wire [3:0] S;
wire Cout;
wire P_block;
wire G_block;

// begin test
initial begin
  $timeformat(-9, 1, " ns", 6); //set time format to nanoseconds
  //create file for waveform dump
  $dumpfile ("Test_CLA_4_wave.vcd");
  $dumpvars (0, Test_CLA_4);

  $monitor ("t=%0t, clk=%b, reset=%b, A=%b, B=%b, Cin=%b, S=%b, Cout=%b", $time, clk, reset, A, B, Cin, S, Cout);

  clk = 0;
  reset = 1;
  A=4'b0;
  B=4'b0;
  Cin=0;

@(posedge clk);
reset = 0;

//test 1+1
  A = 4'b0001; //1
  B = 4'b0001; //1
  Cin = 0;

 repeat (3) @(posedge clk); //wait for positive edge of clock
  //test = 4 bit addition 4 bits of 1 + 1

  reset = 1;
@(posedge clk);
reset = 0;

//test 6+1
  A = 4'b0110; //1
  B = 4'b0001; //1
  Cin = 0;

 repeat (3) @(posedge clk); //wait for positive edge of clock
  //test = 4 bit addition 4 bits of 1 + 1

  reset = 1;
@(posedge clk);
reset = 0;

//test 7+1
  A = 4'b0111; //1
  B = 4'b0001; //1
  Cin = 0;

 repeat (3) @(posedge clk); //wait for positive edge of clock
  //test = 4 bit addition 4 bits of 1 + 1

  reset = 1;
@(posedge clk);
reset = 0;

  A = 4'b1111; //binary test worst case
  B = 4'b0001; //1
  Cin = 0;

  repeat (3) @(posedge clk); //wait for positive edge of clock
  //test = 4 bit addition 4 bits of 1 + 1

  $finish;
end

//potential for future clock and reset implementation
always begin
  #5 clk <= !clk;
end

CLA_4_Clock U0 (
.clk (clk),
.reset (reset),
.A (A),
.B (B),
.Cin (Cin),
.S (S),
.Cout (Cout),
.P_block (P_block),
.G_block (G_block)
);

endmodule
