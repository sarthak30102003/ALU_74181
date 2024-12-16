`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2024 15:59:35
// Design Name: 
// Module Name: ALU_74181
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_74181 (
    input  [3:0] A,    // Input A
    input  [3:0] B,    // Input B
    input  [3:0] S,    // Function select lines
    input  M,          // Mode: 0 = Arithmetic, 1 = Logic
    input  CN,         // Carry input
    output [3:0] F,    // Result
    output Cout,       // Carry out
    output P,          // Propagate
    output G           // Generate
);

    wire [3:0] AND_out, OR_out, XOR_out, NAND_out;
    wire [3:0] SUM, carry;
    wire carry_in, carry_out;

    // Logic operations using gate-level primitives
    and  (AND_out[0], A[0], B[0]);
    and  (AND_out[1], A[1], B[1]);
    and  (AND_out[2], A[2], B[2]);
    and  (AND_out[3], A[3], B[3]);

    or   (OR_out[0], A[0], B[0]);
    or   (OR_out[1], A[1], B[1]);
    or   (OR_out[2], A[2], B[2]);
    or   (OR_out[3], A[3], B[3]);

    xor  (XOR_out[0], A[0], B[0]);
    xor  (XOR_out[1], A[1], B[1]);
    xor  (XOR_out[2], A[2], B[2]);
    xor  (XOR_out[3], A[3], B[3]);

    nand (NAND_out[0], A[0], B[0]);
    nand (NAND_out[1], A[1], B[1]);
    nand (NAND_out[2], A[2], B[2]);
    nand (NAND_out[3], A[3], B[3]);

    // Arithmetic operations: Full Adders
    assign carry_in = CN;

    wire c1, c2, c3;

    full_adder FA0 (.A(A[0]), .B(B[0] ^ S[0]), .Cin(carry_in), .Sum(SUM[0]), .Cout(c1));
    full_adder FA1 (.A(A[1]), .B(B[1] ^ S[0]), .Cin(c1), .Sum(SUM[1]), .Cout(c2));
    full_adder FA2 (.A(A[2]), .B(B[2] ^ S[0]), .Cin(c2), .Sum(SUM[2]), .Cout(c3));
    full_adder FA3 (.A(A[3]), .B(B[3] ^ S[0]), .Cin(c3), .Sum(SUM[3]), .Cout(carry_out));

    // Output multiplexer: Select Arithmetic or Logic
    assign F = M ? 
                (S == 4'b0000 ? AND_out :
                 S == 4'b0001 ? OR_out  :
                 S == 4'b0010 ? XOR_out : NAND_out) : 
                SUM;

    assign Cout = M ? 1'b0 : carry_out;

    // Propagate and Generate outputs
    or  (P, OR_out[0], OR_out[1], OR_out[2], OR_out[3]);
    and (G, AND_out[0], AND_out[1], AND_out[2], AND_out[3]);

endmodule

// Full Adder module at gate level
module full_adder (
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    wire w1, w2, w3;

    xor  (w1, A, B);
    xor  (Sum, w1, Cin);

    and  (w2, A, B);
    and  (w3, w1, Cin);
    or   (Cout, w2, w3);

endmodule
