`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2022 05:20:13 PM
// Design Name: 
// Module Name: t_register
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


module t_register;
    // Inputs
	reg clk;
	reg rst;
	reg write;
	reg [2:0] wr_addr;
	reg [15:0] wr_data;
	reg [2:0] rd_addr_A;
	reg [2:0] rd_addr_B;
	// Outputs
	wire [15:0] rd_data_A;
	wire [15:0] rd_data_B;

    
    register uut(rd_data_A, rd_data_B, clk, rst, write, wr_addr, wr_data, rd_addr_A, rd_addr_B);
    
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
		wr_data = 16'habcd;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 1;
		wr_data = 16'h1234;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 2;
		wr_data = 16'h3456;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 3;
		wr_data = 16'h5678;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 4;
		wr_data = 16'h9122;
		#1 write = 1;
		#1 write = 0;
		
		#10
		wr_addr = 5;
		wr_data = 16'h6768;
		#1 write = 1;
		#1 write = 0;
		
		
		#10
		rd_addr_A = 1;
		rd_addr_B = 2;
		
        
    end
endmodule
