//`include "global.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 06:43:57 PM
// Design Name: 
// Module Name: ALU
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


module ALU(r1, r2, r3, OPCODE);
    input [2:0] r2; // 32 bit input to ALU
    input [2:0] r3; // 32 bit input to ALU
    input [2:0] OPCODE; // ALU Operation
    output reg[5:0] r1; //ALU Output
    always @ (OPCODE or r2 or r3) // Enter the block if either of the inputs are provided
        begin
            case (OPCODE) //type of ALU operation required
                0: r1 = r2+r3; //ADD operation
                1: r1 = r2-r3; //SUB operation
                2: r1 = r2^r3; // XOR operation
                3: r1 = r1 + 1; // INC operation
                default: r1 = 0;
            endcase
        end
endmodule