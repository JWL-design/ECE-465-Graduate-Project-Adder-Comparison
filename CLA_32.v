`timescale 1ns/1ns

module CLA_32 (
    input clk,
    input reset,
    input  [31:0] A,
    input  [31:0] B,
    input  Cin,
    output reg [31:0] S,
    output reg Cout
);

wire [7:0] P_block;
wire [7:0] G_block;
wire [8:0] Carry_block;
wire [31:0] S_int;

//block 0 carry-in
assign Carry_block[0] = Cin;

//block 1 carry-in
assign Carry_block[1] = G_block[0] | (P_block[0] & Carry_block [0]);

//block 2 carry-in
assign Carry_block[2] = G_block[1] | (P_block[1] & Carry_block [1]);

//block 3 carry-in
assign Carry_block[3] = G_block[2] | (P_block[2] & Carry_block [2]);

//block 4 carry-in
assign Carry_block[4] = G_block[3] | (P_block[3] & Carry_block [3]);

//block 5 carry-in
assign Carry_block[5] = G_block[4] | (P_block[4] & Carry_block [4]);

//block 6 carry-in
assign Carry_block[6] = G_block[5] | (P_block[5] & Carry_block [5]);

//block 7 carry-in
assign Carry_block[7] = G_block[6] | (P_block[6] & Carry_block [6]);

//block 8 carry-in
assign Carry_block[8] = G_block[7] | (P_block[7] & Carry_block [7]);


// Instantiate 8 x 4-bit CLA blocks
CLA_4 block0 (
    .A   (A[3:0]),
    .B   (B[3:0]),
    .Cin (Carry_block[0]),
    .S   (S_int[3:0]),
    .Cout (),
    .P_block(P_block[0]),
    .G_block(G_block[0])
);

CLA_4 block1 (
    .A   (A[7:4]),
    .B   (B[7:4]),
    .Cin (Carry_block[1]),
    .S   (S_int[7:4]),
    .Cout (),
    .P_block(P_block[1]),
    .G_block(G_block[1])
);

CLA_4 block2 (
    .A   (A[11:8]),
    .B   (B[11:8]),
    .Cin (Carry_block[2]),
    .S   (S_int[11:8]),
    .Cout (),
    .P_block(P_block[2]),
    .G_block(G_block[2])
);

CLA_4 block3 (
    .A   (A[15:12]),
    .B   (B[15:12]),
    .Cin (Carry_block[3]),
    .S   (S_int[15:12]),
    .Cout (),
    .P_block(P_block[3]),
    .G_block(G_block[3])
);

CLA_4 block4 (
    .A   (A[19:16]),
    .B   (B[19:16]),
    .Cin (Carry_block[4]),
    .S   (S_int[19:16]),
    .Cout (),
    .P_block(P_block[4]),
    .G_block(G_block[4])
);

CLA_4 block5 (
    .A   (A[23:20]),
    .B   (B[23:20]),
    .Cin (Carry_block[5]),
    .S   (S_int[23:20]),
    .Cout (),
    .P_block(P_block[5]),
    .G_block(G_block[5])
);

CLA_4 block6 (
    .A   (A[27:24]),
    .B   (B[27:24]),
    .Cin (Carry_block[6]),
    .S   (S_int[27:24]),
    .Cout (),
    .P_block(P_block[6]),
    .G_block(G_block[6])
);

CLA_4 block7 (
    .A   (A[31:28]),
    .B   (B[31:28]),
    .Cin (Carry_block[7]),
    .S   (S_int[31:28]),
    .Cout (),
    .P_block(P_block[7]),
    .G_block(G_block[7])
);

//reset and clock behavior
always @(posedge clk or posedge reset) begin
   if (reset) begin

        S <= 0;
        Cout <=0;

   end else begin

        S <= S_int;
        Cout <= Carry_block[8];

   end
end

endmodule
