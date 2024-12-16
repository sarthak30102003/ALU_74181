`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2024 16:01:32
// Design Name: 
// Module Name: Test_ALU_74181
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

module ALU_74181_tb;
    reg [3:0] A;       
    reg [3:0] B;       
    reg [3:0] S;       
    reg M, CN;         
    wire [3:0] F;      
    wire Cout, P, G;   

    // Instantiate the ALU module
    ALU_74181 uut (
        .A(A),
        .B(B),
        .S(S),
        .M(M),
        .CN(CN),
        .F(F),
        .Cout(Cout),
        .P(P),
        .G(G)
    );

    // Reduced test cases
    initial begin
        $display("M\tCN\tA\tB\tS\tF\tCout\tP\tG");
        $monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", M, CN, A, B, S, F, Cout, P, G);
        
        // Logic operations
        M = 1; CN = 0;
        A = 4'b0101; B = 4'b1010;
        S = 4'b0000; #10;  // AND operation
        S = 4'b0001; #10;  // OR operation
        S = 4'b0010; #10;  // XOR operation
        S = 4'b0011; #10;  // NOT operation
        
        // Arithmetic operations
        M = 0; CN = 1;
        A = 4'b0101; B = 4'b0001;
        S = 4'b0100; #10;  // Addition

        // Edge cases
        A = 4'b1111; B = 4'b0000; S = 4'b0100; #10; // Max A
        A = 4'b0000; B = 4'b1111; S = 4'b0100; #10; // Max B

        $finish;
    end
endmodule
