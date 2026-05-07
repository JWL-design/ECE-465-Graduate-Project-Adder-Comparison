`timescale 1ns/1ns

module Test_Ripple_32;

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
  $dumpfile ("Test_Ripple_32_wave.vcd");
  $dumpvars (0, Test_Ripple_32);

  $monitor ("t=%0t, clk=%b, reset=%b, A=%b, B=%b, Cin=%b, S=%b, Cout=%b", $time, clk, reset, A, B, Cin, S, Cout);
 

  //set initial conditions
  clk = 0;
  reset = 1;
  A=32'b0;
  B=32'b0;
  Cin=0;

@(posedge clk);
reset = 0;

//test 1+1
  A = 32'b00000000000000000000000000000001; //1
  B = 32'b00000000000000000000000000000001; //1
  Cin = 0;

  repeat (35) @(posedge clk); //wait for positive edge of clock

reset = 1;
@(posedge clk);
reset = 0;

//test 1+6
  A = 32'b00000000000000000000000000000001; //1
  B = 32'b00000000000000000000000000000110; //6
  Cin = 0;

  repeat (35) @(posedge clk); //wait for positive edge of clock

reset = 1;
@(posedge clk);
reset = 0;

//test 1+7
  A = 32'b00000000000000000000000000000001; //1
  B = 32'b00000000000000000000000000000111; //7
  Cin = 0;

  repeat (35) @(posedge clk); //wait for positive edge of clock

reset = 1;
@(posedge clk);
reset = 0;

  //test = 32 bit addition worst case scenario

  A = 32'b11111111111111111111111111111111; //hexadecimal representation of all 1's
  B = 32'b00000000000000000000000000000001; //1
  Cin = 0;

  repeat (35) @(posedge clk); //wait for positive edge of clock

  $finish;
end

//clock cylce generation
always begin
  #5 clk <= !clk;
end

Ripple_Carry_32 U0 (
  .clk (clk),
  .reset (reset),
  .A (A),
  .B (B),
  .Cin (Cin),
  .S (S),
  .Cout (Cout)
);

endmodule
