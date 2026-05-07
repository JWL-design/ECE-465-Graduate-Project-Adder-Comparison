`timescale 1ns/1ps

module CLA_4_Clock (
    input clk,
    input reset,
    input  [3:0] A,
    input  [3:0] B,
    input  Cin,
    output reg [3:0] S,
    output reg Cout,
    output reg P_block,
    output reg G_block
);

wire [3:0] S_int;
wire Cout_int;
wire P_block_int;
wire G_block_int;

//Instantiate the CLA module with strictly combinational logic
CLA_4 U0 (
    .A (A),
    .B (B),
    .Cin (Cin),
    .S(S_int),
    .Cout (Cout_int),
    .P_block (P_block_int),
    .G_block (G_block_int)
);

always @(posedge clk or posedge reset) begin
   if (reset) begin
        S <= 0;
        Cout <=0;
        P_block <= 0;
        G_block <= 0;
   end else begin
        S <= S_int;
        Cout <= Cout_int;
        P_block <= P_block_int;
        G_block <= G_block_int;
   end
end

endmodule
