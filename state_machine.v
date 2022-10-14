`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2022 04:41:45 PM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
     clk, rst
    );
    input clk, rst;
    
    // Enable Signals for the Buttons after Debouncing
	// Should only be high for one cycle for each press
	reg  btn_up_en_prev = 1'b0;
	wire btn_up_en;
	reg  btn_down_en_prev = 1'b0;
	wire btn_down_en;
	reg  btn_left_en_prev = 1'b0;
	wire btn_left_en;
	reg  btn_right_en_prev = 1'b0;
	wire btn_right_en;
	reg  btn_sel_en_prev = 1'b0;
	wire btn_sel_en;
	
	wire [15:0] mem_rd_data_A;
	reg [3:0]  OPCODE;
	reg [11:0] pc = 12'd31;
	reg [3:0]state;
	reg [7:0] init_counter = 0;
	reg [5:0]  operand_1;
	reg [5:0]  operand_2;
    wire [11:0] operand_whole = {operand_1, operand_2};
	
    always@(posedge clk, posedge rst)
    begin
        case(state)
			4'd0: begin
				mem_read(pc, 0);
				reg_read(0, 1);
			
			end //`STATE_HALT
			
			//counter for state machine
			4'd1: begin
				if (init_counter == 8'd200) begin
					state <= 4'd2;
					init_counter <= 0;
				end else begin
					init_counter <= init_counter + 1'b1;
				end
				
			end //`STATE_INIT
			
			4'd2: begin
				mem_read(pc, 0);
				state <= 4'd3;
			end //`STATE_PRE_FETCH
			
			4'd3: begin
				mem_reset_wr_en();
				reg_reset_wr_en();
				state <= 4'd5;
				
			end //`STATE_FETCH
				
			4'd5: begin
				OPCODE <= mem_rd_data_A[15:12];
				operand_1 <= mem_rd_data_A[11:6];
				operand_2 <= mem_rd_data_A[5:0];
				state <= 4'd4;
			end //`STATE_READ_OPERANDS
		
			4'd4: begin
				decode();
			end //`STATE_DECODE
		
			 4'd6: begin
				state <= 4'd8;
			end //`STATE_ALU_OPS
		
			4'd7: begin
				state <= 4'd8;
			end //`STATE_MEM_OPS
		
			4'd8: begin
				reg_write(operand_1, operand_2);
				state <= 4'd2;
			end //`STATE_WRITE_RESULT
		
			4'd9: begin
				state <= 4'd0;
			end //`STATE_READ_REG
		
		endcase
	end
    
endmodule
