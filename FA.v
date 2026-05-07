`timescale 1ns/1ps
module FA (
    //define inputs and outputs
    input A,
    input B,
    input Cin,
    input clk,
    input reset,
    //ouput ports
    output reg S,
    output reg Cout
);

always @(posedge clk or posedge reset)
    if (reset) begin
        S <= 0;
        Cout<= 0;
    end

    else begin
    //Sum = (A XOR B) XOR Cin
        S <= (A ^ B) ^ Cin;
    //Cout = (A.B) + (Cin.(A XOR B))
        Cout <= (A & B) | (Cin & (A ^ B));
    end

endmodule
