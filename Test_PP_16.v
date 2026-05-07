`timescale 1ns/1ns

module Test_PP_16;

//inputs
reg clk;
reg reset;
reg [15:0] A;
reg [15:0] B;
reg Cin;
//outputs
wire [15:0] S;
wire Cout;

// begin test
initial begin
  $timeformat(-9, 1, " ns", 6); //set time format to nanoseconds
  //create file for waveform dump
  $dumpfile ("Test_PP_16_wave.vcd");
  $dumpvars (0, Test_PP_16);

  $monitor ("t=%0t, clk=%b, reset=%b, A=%b, B=%b, Cin=%b, S=%b, Cout=%b", $time, clk, reset, A, B, Cin, S, Cout);
  clk = 0;
  reset = 1;
  A=16'b0;
  B=16'b0;
  Cin=0;

@(posedge clk);
reset = 0;

//test 1+1
  A = 16'b0000000000000001; //1
  B = 16'b0000000000000001; //1
  Cin = 0;

  repeat (5) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test 6+1
  A = 16'b0000000000000110; //6
  B = 16'b0000000000000001; //1
  Cin = 0;

  repeat (5) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test 7+1
  A = 16'b0000000000000111; //7
  B = 16'b0000000000000001; //1
  Cin = 0;

  repeat (5) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test worst-case scenario for watching carry
  A = 16'b1111111111111111; //binary test worst case
  B = 16'b0000000000000001; //1
  Cin = 0;

  repeat (5) @(posedge clk); //wait for positive edge of clock

  $finish;
end

// clock generation
always begin
  #5 clk <= !clk;
end

PP_16 U0 (
.clk (clk),
.reset (reset),
.A (A),
.B (B),
.Cin (Cin),
.S (S),
.Cout (Cout)
);

endmodule
