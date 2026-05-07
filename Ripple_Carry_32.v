`timescale 1ns/1ns
module Ripple_Carry_32 (
    
    //assign ports into blackbox
    input clk,
    input reset,
    input [31:0] A,
    input [31:0] B,
    input Cin, // only one carry in bit for full blackbox
    output [31:0] S,
    output Cout //only one carry out bit for full blackbox

);

wire [32:0] Carry; //internal wires for carry in between full adder blocks
genvar i; //integer i for full adder loop

assign Carry[0] = Cin; //assign first carry wire to Cin

//test other 31 adder blocks with for loop
//using generate variable i
generate
    for (i=0; i<32; i=i+1) begin:add_loop
        FA FullAdd (
            .clk (clk),
            .reset (reset),
            .A (A[i]),
            .B (B[i]),
            .Cin (Carry[i]),
            .S (S[i]),
            .Cout (Carry[i+1])
        );
    end
endgenerate

assign Cout = Carry[32]; //assign final carry wire to Cout

endmodule
