`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2022 03:45:24 PM
// Design Name: 
// Module Name: t_bouncer
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


module t_bouncer();
//      reg clock;
//    reg button;
//    wire button_sync;
//    wire button_sync_db;
//    wire edj;
//    wire rise;
//    wire fall;

//    Sync Sync_Inst
//    (
//        .clock(clock),
//        .in(button),
//        .out(button_sync)
//    );

//    debouncer
//    #(
//        .MAX_COUNT(4)
//    )
//    Debounce_Inst
//    (
//        .clock(clock),
//        .in(button_sync),
//        .out(button_sync_db),
//        .edj(edj),
//        .rise(rise),
//        .fall(fall)
//    );

//    initial
//    begin
//        clock = 0;
//    end

//    always #5 clock = ~clock;

//    always
//    begin
//        #2 button = 0; #20 button = 1; #20 button = 0;
//        #22 button = 1; #20 button = 1; #20 button = 0; #20 button = 1;
//        #22 button = 1; #20 button = 0; #20 button = 0; #20 button = 1;
//        #22 button = 0; #20 button = 1; #20 button = 1; #20 button = 0;
//        #80 $stop;
//    end

    // Inputs
	reg rst;
	reg btn_raw;
	reg clk;
	reg btn_pressed;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.rst(rst),
		.clk(clk), 
		.noisy(btn_raw), 
		.clean(btn_pressed)
	);

	initial begin
		// Initialize Inputs
		btn_raw = 0;
		clk = 0;
		btn_pressed = 0;

		// Wait 10 us for global reset to finish
		#10;
        
		// Stimulus
		//#7000 btn_raw = 1;

	end
	
	always begin
		#500 clk = !clk;
	end
endmodule
