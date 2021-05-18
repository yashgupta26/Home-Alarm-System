//////////////////////////////////////////////////////////////////////////////////
// There are 4 seven segment display on our FPGA, inorder to select the
// correct display for our output, we need a module that can  
// assign the corresponsing output to the display we need.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1s / 1ms
module seven_segment_driver(clk,clr,in1,in2,in3,in4,seg,an);

input clk, clr;
input [3:0] in1, in2, in3, in4;
output reg [6:0] seg;
output reg [3:0] an;

wire [6:0] seg1, seg2, seg3, seg4;
  reg [12:0] segclk=0;

localparam LEFT = 2'b00, MIDLEFT = 2'b01, MIDRIGHT = 2'b10, RIGHT = 2'b11;
reg [1:0] state=LEFT;

//instantiating seven_segment_decoder module for 4 displays
seven_segment_decoder disp1(in1,seg1);
seven_segment_decoder disp2(in2,seg2);
seven_segment_decoder disp3(in3,seg3);
seven_segment_decoder disp4(in4,seg4);

always @ (posedge clk) 
segclk <= segclk + 1'b1;

  always @ (posedge segclk or posedge clr)
begin
    if (clr == 1)
	begin
	    seg <= 7'b0000000;
	    an <= 4'b0000;
	    state <= LEFT;
	end
	
	else
	begin	   
	case (state)
	LEFT:
	   begin
	   seg <= seg1;
	   an <= 4'b0111;
	   state <= MIDLEFT;
	   end
	MIDLEFT:
	   begin
	   seg <= seg2;
	   an <= 4'b1011;
	   state <= MIDRIGHT;
	   end
	MIDRIGHT:
	   begin
	   seg <= seg3;
	   an <= 4'b1101;
	   state <= RIGHT;
	   end
	RIGHT:
	   begin
	   seg <= seg4;
	   an <= 4'b1110;
	   state <= LEFT;
	   end 
	endcase
	end
end

endmodule
