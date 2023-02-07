`timescale 1ns / 1ns

`define CHAR_SPACE 0
`define CHAR_A 1
`define CHAR_B 2
`define CHAR_C 3
`define CHAR_D 4
`define CHAR_E 5
`define CHAR_F 6
`define CHAR_G 7
`define CHAR_H 8
`define CHAR_I 9
`define CHAR_J 10
`define CHAR_K 11
`define CHAR_L 12
`define CHAR_M 13
`define CHAR_N 14
`define CHAR_O 15
`define CHAR_P 16
`define CHAR_Q 17
`define CHAR_R 18
`define CHAR_S 19
`define CHAR_T 20
`define CHAR_U 21
`define CHAR_V 22
`define CHAR_W 23
`define CHAR_X 24
`define CHAR_Y 25
`define CHAR_Z 26
`define CHAR_0 27
`define CHAR_1 28
`define CHAR_2 29
`define CHAR_3 30
`define CHAR_4 31
`define CHAR_5 32
`define CHAR_6 33
`define CHAR_7 34
`define CHAR_8 35
`define CHAR_9 36


module display(
	input  wire [10:0] vga_h_ctr, //from vgacontrol counter
	input  wire [10:0] vga_v_ctr, //from vgacontrol counter
	output wire 	   vga_pixel_on,

	output wire [ 3:0] seg7_digit_sel,
	output wire [ 7:0] seg7_led_on,

	input  wire [15:0] r0, //from cpu regfile data bus
	input  wire [15:0] r1,
	input  wire [15:0] r2,
	input  wire [15:0] r3,
	input  wire [15:0] r4,
	input  wire [15:0] r5,
	input  wire [15:0] r6,

	input  wire        clk,
	input  wire        rst
);
	reg [7:0] init;
	reg [5:0] init_char;
	reg [7:0] init_h;
	reg [7:0] init_v;
	wire init_en;
	localparam init_steps = 15;

	reg  [4:0] register_disp_counter;
	reg  [3:0] register_hex;
	reg  [5:0] register_char;
	wire [5:0] register_h;
	wire [5:0] register_v;

	wire [7:0] term_h;
	wire [7:0] term_v;
	wire [5:0] term_char;
	reg        term_w_en;
	
	seg_display sd(
		.num(r6[11:0]),
		.led_on(seg7_led_on),
		.digit_select(seg7_digit_sel),
		.clk(clk),
		.rst(rst)
	);

	vga_display vd(
		.w_h_addr(term_h),
		.w_v_addr(term_v),
		.w_data(term_char), //EXAMPLE: 1, 2, 3, 4 ,5 ,6, A, B, C, D
		.w_en(term_w_en),

		.h_ctr(vga_h_ctr),
		.v_ctr(vga_v_ctr),
		.pixel_on(vga_pixel_on),

		.clk(clk),
		.rst(rst)
	);

	assign init_en = (init != init_steps);

	assign term_h    = init_en ? init_h    : register_h;
	assign term_v    = init_en ? init_v    : register_v;
	assign term_char = init_en ? init_char : register_char;

	assign register_h = register_disp_counter[1:0] + 3;
	assign register_v = register_disp_counter[4:2];
	
	//every reg num is 16 bits, 4 hex are showed in the monitor. total 28 for 6 registers 
	always @(*) begin
		case (register_disp_counter)
			 0: register_hex = r0[15:12];
			 1: register_hex = r0[11: 8];
			 2: register_hex = r0[ 7: 4];
			 3: register_hex = r0[ 3: 0];
			 4: register_hex = r1[15:12];
			 5: register_hex = r1[11: 8];
			 6: register_hex = r1[ 7: 4];
			 7: register_hex = r1[ 3: 0];
			 8: register_hex = r2[15:12];
			 9: register_hex = r2[11: 8];
			10: register_hex = r2[ 7: 4];
			11: register_hex = r2[ 3: 0];
			12: register_hex = r3[15:12];
			13: register_hex = r3[11: 8];
			14: register_hex = r3[ 7: 4];
			15: register_hex = r3[ 3: 0];
			16: register_hex = r4[15:12];
			17: register_hex = r4[11: 8];
			18: register_hex = r4[ 7: 4];
			19: register_hex = r4[ 3: 0];
			20: register_hex = r5[15:12];
			21: register_hex = r5[11: 8];
			22: register_hex = r5[ 7: 4];
			23: register_hex = r5[ 3: 0];
			24: register_hex = r6[15:12];
			25: register_hex = r6[11: 8];
			26: register_hex = r6[ 7: 4];
			27: register_hex = r6[ 3: 0];
			default: register_hex = 4'b0000;
		endcase
	end

	always @(*) begin
		case(register_hex)
			 0: register_char = `CHAR_0;
			 1: register_char = `CHAR_1;
			 2: register_char = `CHAR_2;
			 3: register_char = `CHAR_3;
			 4: register_char = `CHAR_4;
			 5: register_char = `CHAR_5;
			 6: register_char = `CHAR_6;
			 7: register_char = `CHAR_7;
			 8: register_char = `CHAR_8;
			 9: register_char = `CHAR_9;
			10: register_char = `CHAR_A;
			11: register_char = `CHAR_B;
			12: register_char = `CHAR_C;
			13: register_char = `CHAR_D;
			14: register_char = `CHAR_E;
			15: register_char = `CHAR_F;
		endcase
	end

	always @(posedge clk) begin
		if (rst) begin
			init <= 0;
		end else if (init_en) begin
			init <= init + 1;
		end
	end
	
	always @(posedge clk) begin
		if (rst) begin
			register_disp_counter <= 0;
		end else if (register_disp_counter >= 27) begin
			register_disp_counter <= 0;
		end else begin
			register_disp_counter <= register_disp_counter + 1;
		end
	end

	always @(posedge clk) begin
		case (init)
			0: begin
				term_w_en <= 1;
				init_h <= 0;
				init_v <= 0;
				init_char <= `CHAR_R;
			end
			1, 2, 3, 4, 5, 6: init_v <= init_v + 1;
			7: begin
				init_h <= 1; 
				init_v <= 0; 
				init_char <= `CHAR_0;
			end
			8, 9, 10, 11, 12, 13, 14: begin
				init_v <= init_v + 1;
				init_char <= init_char + 1;
			end
		endcase
	end
endmodule

