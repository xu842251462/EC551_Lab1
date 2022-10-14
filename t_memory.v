`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 09:27:35 PM
// Design Name: 
// Module Name: t_memory
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


module t_memory(

    );
    // Inputs
	reg clk;
	reg rst;
	reg write;
	reg [2:0] wr_addr;
	reg [11:0] wr_data;
	reg [2:0] rd_addr_A;
	reg [2:0] rd_addr_B;

	// Outputs
	wire [11:0] rd_data_A;
	wire [11:0] rd_data_B;

	// Instantiate the Unit Under Test (UUT)
	memory uut (rd_data_A, rd_data_B, clk, rst, write, wr_addr, wr_data, rd_addr_A, rd_addr_B);

	always begin
        #1 clk = ~clk;
    end 
    
    initial 
    begin
       // Initialize Inputs
		clk = 0;
		rst = 0;
		write = 0;
		wr_addr = 0;
		wr_data = 0;
		rd_addr_A = 0;
		rd_addr_B = 0;
		
		
		// Add stimulus here
		wr_addr = 0;
		wr_data = 12'd10;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 1;
		wr_data = 12'd1234;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 2;
		wr_data = 12'd2345;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 3;
		wr_data = 12'd576;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 4;
		wr_data = 12'd900;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 5;
		wr_data = 12'b1000;
		#1 write = 1;
		#1 write = 0;
		
		
		#10
		rd_addr_A = 1;
		rd_addr_B = 2;
	end
	endmodule