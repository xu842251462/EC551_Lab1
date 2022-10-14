`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2022 12:38:18 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    clk_out, clk, rst
    );
    input clk, rst;
    output reg clk_out;
    reg [7:0]count;
   
    localparam constantNumber = 50000000;
  
    always@(posedge rst or posedge clk or clk_out or count)
        begin
            if (rst == 1) begin
                clk_out <= 0;
                count <= 0;
                end
            if (rst == 0 && count < constantNumber - 1) begin
                clk_out <= clk_out;
                count = count + 1;
                end 
            else if (rst == 0 && count == constantNumber - 1) begin 
                clk_out = ~clk_out;
                count <= 0;
                end
        end
endmodule
