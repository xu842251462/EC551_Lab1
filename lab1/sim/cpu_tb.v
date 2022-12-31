`timescale 1ns / 1ns


module t_CPU();
	reg clk;
	reg rst;
	wire [15:0] r0, r1, r2, r3, r4, r5, r6;

	Cpu uut(
		.clk(clk),
		.rst(rst),
		.unhalt(1'b0),
		.regexpose({r0, r1, r2, r3, r4, r5, r6})
	);

	initial begin
		clk = 1;
		forever #10 clk = ~clk;
	end

	initial begin
		rst = 1;
		#10 rst = 0;
		#10 rst = 1;
		#10 rst = 0;
	end

endmodule
