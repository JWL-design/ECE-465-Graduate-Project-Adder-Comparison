`timescale 1ns/1ns

module PP_16 (
    //define variables
    input clk,
    input reset,
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output reg [15:0] S,
    output reg Cout
);

//assign intermittent Sum
wire [15:0] S_int;
assign S_int = A ^ B;

//step 1: Precomuptation - generate and propagate for individual columns includes Cin as column i=-1
wire [16:0] P0, G0;

// generate and propagate for carry-in column (-1)
assign G0[0] = Cin;
assign P0[0] = 0;


// generate and propagate for 0 through 15 individual columns
genvar i;
generate
    for (i=0; i<16; i=i+1) begin:loop0
        
        assign P0[i+1] = A[i] | B[i];
        assign G0[i+1] = A[i] & B[i];

    end
endgenerate

// step 2: Prefix propagate and generate for pairs
//every other column should have prefix calculated
wire [16:0] G1, P1;

genvar j1,k1;

generate
    for (j1 = 0; j1 <= 16; j1 = j1 + 2) begin: loop1
        for (k1 =0; k1 <2; k1 = k1 + 1) begin: loop1_1
            if ((j1+k1) <=16) begin
                if (k1 < 1) begin

                    assign P1[j1+k1] = P0[j1+k1];
                    assign G1[j1+k1] = G0[j1+k1];

                end else begin

                    assign P1[j1+k1] = P0[j1+k1] & P0[j1];
                    assign G1[j1+k1] = G0[j1+k1] | (P0[j1+k1] & G0[j1]);  

                end  
            end
        end
    end
endgenerate
       

// step 3: Prefix:  propagate and generate for groups of 4 columns
wire [16:0] G2, P2;

genvar j2, k2;

generate
    for (j2 = 0; j2 <= 16; j2 = j2 + 4) begin:loop2
        for (k2 = 0; k2 <= 4; k2 = k2 + 1) begin:loop2_1
            if ((j2+k2) <=16) begin
                if (k2 < 2) begin

                    assign P2[j2+k2] = P1[j2+k2];
                    assign G2[j2+k2] = G1[j2+k2];

                end else begin

                    assign P2[j2+k2] = P1[j2+k2] & P1[j2+1];
                    assign G2[j2+k2] = G1[j2+k2] | (P1[j2+k2] & G1[j2+1]);

                end  
            end
        end
    end
endgenerate

// step 4: Prefix: propagate and generate for groups of 8 columns

wire [16:0] G3, P3;

genvar j3, k3;
generate
    for (j3=0; j3<=16; j3=j3+8) begin:loop3
        for (k3=0; k3<8; k3=k3+1) begin:loop3_1
            if ((j3+k3)<=16) begin
                if (k3 < 4) begin

                    //every column 0-3 of 8 column groups should pass through
                    assign P3[j3+k3] = P2[j3+k3];
                    assign G3[j3+k3] = G2[j3+k3];

                end else begin
                    //every column 4-7 of 8 column groups should have prefix calculated

                    assign P3[j3+k3] = P2[j3+k3] & P2[j3+3];
                    assign G3[j3+k3] = G2[j3+k3] | (P2[j3+k3] & G2[j3+3]);

                end
            end
        end
    end
endgenerate


// step 5: Prefix: propagate and generate for groups of 16 columns

wire [16:0] G4, P4;
genvar j4, k4;
generate
    for (j4=0; j4<=16; j4=j4+16) begin:loop4
        for (k4=0; k4<16; k4=k4+1) begin:loop4_1
            if ((j4+k4)<=16) begin
                if (k4 < 8) begin

                    //every column 0-3 of 8 column groups should pass through
                    assign P4[j4+k4] = P3[j4+k4];
                    assign G4[j4+k4] = G3[j4+k4];

                end else begin
                    //every column 4-7 of 8 column groups should have prefix calculated

                    assign P4[j4+k4] = P3[j4+k4] & P3[j4+7];
                    assign G4[j4+k4] = G3[j4+k4] | (P3[j4+k4] & G3[j4+7]);

                end
            end
        end
    end
endgenerate

// step 6:  Prefix calculate generate/propagate for column 16 (carry-out column)

wire [16:0] G5;
//for future use if increased to 32-bit
//wire [16:0] P5;

generate
    for (i=0; i<=16; i=i+1) begin:loop5
        if (i<16) begin
            //pass every column besides column 16 through to postcomputation
            //assign P5[i] = P4[i]; for future 32-bit
            assign G5[i] = G4[i];

        end else begin
            //only column 16 should have prefix calculated
            //assign P5[i] = P4[i] & P4[i-16]; for future 32-bit
            assign G5[i] = G4[i] | (P4[i] & G4[15]);     

        end
    end
endgenerate

//Postcomputation:calculate sum 
wire [15:0] S_total;

generate
    for (i=0; i <16; i=i+1) begin:loop_sum

        assign S_total[i] = S_int[i] ^ G5[i];

    end
endgenerate


wire Cout_total;
assign Cout_total = G5[16];

//reset and clock behavior
always @(posedge clk or posedge reset) begin
   if (reset) begin

        S <= 0;
        Cout <=0;

   end else begin
    //store sum and carry-out in registers on clock edge if reset = 0
        S <= S_total;
        Cout <= Cout_total;

   end
end

endmodule
