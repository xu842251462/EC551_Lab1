`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 09:31:09 PM
// Design Name: 
// Module Name: t_ALU
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


module t_ALU(

    );
    // Inputs
	reg [2:0] r2;
	reg [2:0] r3;
	reg [2:0] OPCODE;

	// Outputs
	wire [5:0] r1;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.r2(r2), 
		.r3(r3), 
		.OPCODE(OPCODE), 
		.r1(r1)
	);

	initial begin
	#100 $finish;
	end

	initial begin
        r2 = 3'd0;
        r3 = 3'd1;
        OPCODE =0;
        #20 OPCODE=0;
        #20 OPCODE=1;
        #20 OPCODE=2;
        #20 OPCODE=3;
	end
endmodule
