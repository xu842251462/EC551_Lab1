`timescale 1ns / 1ns


module Memory(
	input  wire [11:0] r_addr,
	output reg  [15:0] r_data,

	input  wire [11:0] w_addr,
	input  wire [15:0] w_data,
	input  wire        w_en,

	input  wire [11:0] pc,
	output reg  [15:0] inst,

	input  wire        clk, 
	input  wire        rst
);
	reg [15:0] memory[4095:0];

	integer ii;
	initial begin
		$readmemb("memory.list", memory);
	end
	
	always @(negedge clk) begin
		r_data <= memory[r_addr];
	end
	
	always @(posedge clk) begin
		if (rst) begin
			inst <= 16'b1010_000000_000000; // mov r0 r0 (noop)
		end else begin
			inst <= memory[pc];
		end
	end

	always @(posedge clk) begin
		if (rst) begin
		end 
		else if (w_en) 
			memory[w_addr] <= w_data;		
	end

endmodule

