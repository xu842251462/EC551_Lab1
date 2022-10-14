`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 06:46:41 PM
// Design Name: 
// Module Name: decoder
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


module decoder(state, OPCODE);
    // get OPCODE from cpu memory assign last 4 bits
    input [3:0]OPCODE;
    //// CPU Program Counter register
    output reg [4:0]state;
    reg [11:0] pc = 12'd31;
    reg [5:0]  operand_1;
	reg [5:0]  operand_2;
    wire [11:0] operand_whole = {operand_1, operand_2};
   
    always@(OPCODE);
        initial
		begin
			case(OPCODE)
				//HALT
				4'b0000: begin
					state <= 4'd0;
				end
				// Increment Register
				4'b0001: begin
					pc <= operand_whole;
					state <= 4'd2;
				end
				// Jump if not equal Op Code
				4'b0011: begin
					if (!operand_1 == operand_2) begin
						pc <= operand_whole;
						state <= 4'd2;
					end else begin
						pc <= pc + 1'b1;
						state <= 4'd2;
					end
				end
				// Jump if equal Op Code
				4'b0100: begin
					if (operand_1 == operand_2) begin
						pc <= operand_whole;
						state <= 4'd2;
					end else begin
						pc <= pc + 1'b1;
						state <= 4'd2;
					end
				end
				//Increment Register
				4'b0001 : begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//ADD
				4'b0101: begin
					reg_read(operand_1, operand_2);
					pc <= pc + 1'b1;
					state <= 4'd6;
				end
				// Sub Op Code, param 1 Rn
				4'b0110: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//XOR
				4'b0111: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//compare opcode
				4'b1000: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//SADD: Signed Add
				4'b1101: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//SSUB: Signed Subtract
				4'b1110: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//Signed Multiply
				4'b1111: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//Move Rn, Num
				4'b1001: begin
					pc <= pc + 1'b1;
					state <= 4'd8;
				end
				//Move contents of Rm into Rn
				4'b1010: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				//Move contents of Rm into address stored in Rn
				4'b1011: begin
					pc <= pc + 1'b1;
					//we nned the state operand
					state <= 4'd5;
				end
				//Move contents of memory address in Rm into Rn    
				4'b1100: begin
					pc <= pc + 1'b1;
					state <= 4'd5;
				end
				
			endcase
		end
        
endmodule
