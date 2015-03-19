module clkDivider_8Hz ( clk50M, clk1, reset);
input clk50M, reset;
output reg clk1;

reg [22:0] count; //6,250,000

always @ (posedge clk50M or negedge reset)
begin
	if(!reset) begin
		count <= 0;
		clk1 <= 0;
	end
	else if (count == 3124999) begin
		clk1 <= ~clk1;
		count <= 0;
	end
	count <= count + 1;
end
endmodule