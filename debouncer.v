`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 08:25:37 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
//#(
//    parameter MAX_COUNT = 16
//)
//(
//    input wire clock,
//    input wire in,    // Synchronous and noisy input.
//    output reg out,   // Debounced and filtered output.
//    output reg edj,   // Goes high for 1 clock cycle on either edge of output. Note: used "edj" because "edge" is a keyword.
//    output reg rise,  // Goes high for 1 clock cycle on the rising edge of output.
//    output reg fall   // Goes high for 1 clock cycle on the falling edge of output.
//);

//    localparam COUNTER_BITS = $clog2(MAX_COUNT);

//    reg [COUNTER_BITS - 1 : 0] counter;
//    wire w_edj;
//    wire w_rise;
//    wire w_fall;

//    initial
//    begin
//        counter = 0;
//        out = 0;
//    end

//    always @(posedge clock)
//    begin
//        counter <= 0;  // Freeze counter by default to reduce switching losses when input and output are equal.
//        edj <= 0;
//        rise <= 0;
//        fall <= 0;
//        if (counter == MAX_COUNT - 1)  // If successfully debounced, notify what happened.
//        begin
//            out <= in;
//            edj <= w_edj;    // Goes high for 1 clock cycle on either edge.
//            rise <= w_rise;  // Goes high for 1 clock cycle on the rising edge.
//            fall <= w_fall;  // Goes high for 1 clock cycle on the falling edge.
//        end
//        else if (in != out)  // Hysteresis.
//        begin
//            counter <= counter + 1;  // Only increment when input and output differ.
//        end
//    end

//    // Edge detect.
//    assign w_edj = in ^ out;
//    assign w_rise = in & ~out;
//    assign w_fall = ~in & out;
    input  wire btn_in,
	output wire signal_out,
	input  wire clk,
	input  wire rst 
);
	reg [21:0] counter;

	assign signal_out = (counter > 22'b1000000000000000000000);

	always @(posedge clk) begin
		if (rst) begin
			counter <= 22'b1000000000000000000000;
		end else if (btn_in) begin
			if (counter < 22'b1111111111111111111111) begin
				counter <= counter + 1;
			end
		end else if (~btn_in) begin
			if (counter > 22'b0000000000000000000000) begin
				counter <= counter - 1;
			end
		end
	end
 
 endmodule