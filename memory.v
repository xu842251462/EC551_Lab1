`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 09:11:23 PM
// Design Name: 
// Module Name: memory
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


module memory(
   rd_data_A, rd_data_B, clk, rst, write, wr_addr, wr_data, rd_addr_A, rd_addr_B
);

    input         clk;
    input         rst;
    input         write;
    input  [2:0]  wr_addr;
    input  [11:0] wr_data;
   
    input  [2:0]  rd_addr_A;
    input  [2:0]  rd_addr_B;
   
    output [11:0] rd_data_A;
    output [11:0] rd_data_B;
    
    reg [11:0] memfile [0:60];
	reg [11:0] data_A = 11'b0;
	reg [11:0] data_B = 11'b0;
	   
	assign rd_data_A = data_A;
	assign rd_data_B = data_B;
	
	initial begin
		$readmemh("data.txt", memory);
	end
	
	always @ (posedge clk) begin
	   if (rst) begin
	        memfile[31] <= 12'b0;
			memfile[32] <= 12'b0;
			memfile[33] <= 12'b0;
			memfile[34] <= 12'b0;
			memfile[35] <= 12'b0;
			memfile[36] <= 12'b0;
		end 
		//write
	   if (!rst && write) begin
	       memfile[wr_addr] <= wr_data; 
	   end
	   //read
	   data_A = memfile[rd_addr_A];
	   data_B = memfile[rd_addr_B];
	   
	end
 endmodule