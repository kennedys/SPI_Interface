`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 23:15:38 02/11/2014
// Design Name: master
// Module Name: C:/Users/hojmang/Documents/cpe187/spibus/top_tb.v
// Project Name: spibus
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: master
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module toptest;
// Inputs
reg clk;
reg [7:0] data_in;
reg start;
reg rst;
// Outputs
output reg [7:0] data_out;
wire mosi;
wire sclk;
wire busy;
wire new_data;
// Instantiate the Unit Under Test (UUT)
SPI_Interface master1 (
.clk(clk),
.reset(reset),
.miso(miso),
.mosi(mosi),
.sck(sck),
.start(start),
.data_in(data_in),
.data_out(data_out),
.busy(busy)
);
// slave slave1 (
// .mosi(mosi),
// .sclk(sclk),
// .ss(ss),
// .miso(miso),
// .rdata(rdata)
// );
always #10 clk = ~clk;
initial begin
// Initialize Inputs
clk = 0;
din = 8'b00000000;
start = 0;
rst = 1;
// Wait 100 ns for global reset to finish
#10;
// Add stimulus here
rst = 0;
#10;
rst = 1;
#10;
data_in = 8'b00000101;
start = 1;
#10;
start = 0;
#400;
start = 1;
#10;
start = 0;
end
endmodule
