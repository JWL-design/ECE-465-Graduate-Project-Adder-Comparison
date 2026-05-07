`timescale 1ns/1ns

module Test_CLA_32;

//inputs
reg clk;
reg reset;
reg [31:0] A;
reg [31:0] B;
reg Cin;
//outputs
wire [31:0] S;
wire Cout;

// begin test
initial begin
  $timeformat(-9, 1, " ns", 6); //set time format to nanoseconds
  //create file for waveform dump
  $dumpfile ("Test_CLA_32_wave.vcd");
  $dumpvars (0, Test_CLA_32);

  $monitor ("t=%0t, clk=%b, reset=%b, A=%b, B=%b, Cin=%b, S=%b, Cout=%b", $time, clk, reset, A, B, Cin, S, Cout);
  clk = 0;
  reset = 1;
  A=32'b0;
  B=32'b0;
  Cin=0;

@(posedge clk);
reset = 0;

//test 1+1
  A = 32'b00000001; //1
  B = 32'b00000001; //1
  Cin = 0;

  repeat (10) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test 6+1
  A = 32'b00000110; //6
  B = 32'b00000001; //1
  Cin = 0;

  repeat (10) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test 7+1
  A = 32'b00000111; //7
  B = 32'b00000001; //1
  Cin = 0;

  repeat (10) @(posedge clk); //wait for positive edge of clock
 
reset = 1;
@(posedge clk);
reset = 0;

//test worst-case scenario for watching carry
  A = 32'b11111111111111111111111111111111; //binary test worst case
  B = 32'b00000000000000000000000000000001; //1
  Cin = 0;

  repeat (10) @(posedge clk); //wait for positive edge of clock

  $finish;
end

// clock generation
always begin
  #5 clk <= !clk;
end

CLA_32 U0 (
.clk (clk),
.reset (reset),
.A (A),
.B (B),
.Cin (Cin),
.S (S),
.Cout (Cout)
);

endmodule
