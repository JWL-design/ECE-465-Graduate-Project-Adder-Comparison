`timescale 1ns/1ps

module CLA_4 (
    input  [3:0] A,
    input  [3:0] B,
    input  Cin,
    output [3:0] S,
    output Cout,
    output P_block,
    output G_block
);

wire carry0, carry1, carry2, carry3;
wire [3:0] P, G;

//From Harris and Harris:
//within 4-bit block
//column i propagates a carry if either A or B is 1
genvar i;

generate
    for (i=0; i<4; i=i+1) begin:pg_loop
        //column i propagates a carry if either A or B is 1
        assign P[i] = A[i] | B[i];
        //column i generates a carry if A & B are both 1
        assign G[i] = A[i] & B[i];

    end
endgenerate

// 4-bit ripple carry inside the block
//within 4-bit block
//C_out(i) = G(i) + P(i) & C_in(i-1)
assign carry0 = Cin;
assign carry1   = G[0] | (P[0] & carry0);
assign carry2   = G[1] | (P[1] & carry1);
assign carry3   = G[2] | (P[2] & carry2);


assign S[0] = A[0] ^ B[0] ^ carry0;
assign S[1] = A[1] ^ B[1] ^ carry1;
assign S[2] = A[2] ^ B[2] ^ carry2;
assign S[3] = A[3] ^ B[3] ^ carry3;

// Block-Level Generation and Propagation
//From Harris and Harris
assign P_block = P[3] & P[2] & P[1] & P[0];

assign G_block = G[3] |
                    (P[3] & G[2]) |
                    (P[3] & P[2] & G[1]) |
                     (P[3] & P[2] & P[1] & G[0]);

assign Cout = G_block | (P_block & Cin);

endmodule
