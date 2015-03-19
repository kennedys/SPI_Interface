module SPI_Master( input clk_50M,
						 input reset,
						 input MISO_bit,
						 input [2:0] address,
						 output reg SCLK,
						 output reg MOSI_bit,
						 output reg SS,
						 output reg [6:0] SevSeg
						);
						
	reg edgeTrigger; //1 if rising, 0 if falling
	reg loadReg;
	reg [7:0] data;
	reg [5:0] bitCount;
	wire clk_16Hz;
	wire clk_8Hz;
	
   clkDivider_16Hz u0( clk_50M, clk_16Hz, reset);
	clkDivider_8Hz u1( clk_50M, clk_8Hz, reset);
	
	initial begin
		edgeTrigger = 0;
		loadReg = 0;
		data = 8'b00000000;
		bitCount = 5'b00000;
		SevSeg = 8'b00000000;
	end
	
	//This block will send data to the slave on rising edge
	always @ (posedge clk_16Hz or negedge reset) begin
			if(edgeTrigger && !SS) begin
				MOSI_bit <= data[7];
			end
			else if (!edgeTrigger && !SS) begin
				data <={data[6:0], MISO_bit};
				bitCount <= bitCount + 1;
			end else if (loadReg) begin
				data <= {5'b00000, address};
			end else if (!reset)begin
				data <= {5'b00000, address};
				bitCount <= 5'b00000;
			end
		
			if (bitCount == 16) begin
				bitCount <= 5'b00000;
			end
			
			if (!reset)begin
				
				
			end
			
			edgeTrigger <= ~edgeTrigger;
	end
	
	//Always block will drive a 
	always @ (*) begin
			
			if(bitCount == 16) begin
				SevSeg <= ~data[6:0];
				SS <= 0;
				SCLK <= 0;
				loadReg <= 0;
			end else if(bitCount == 0) begin
				loadReg <= 1;
			end
			else begin
				loadReg <= 0;
				SS <= 1;
				SCLK <= clk_8Hz;
			end
			
			
	end
	
	
endmodule