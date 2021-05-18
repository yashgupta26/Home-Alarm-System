//////////////////////////////////////////////////////////////////////////////////
// This is the main module describing the internal processing of
// our home alarm system.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1s / 1ms
module home_alarm(clk,pass,act,door,win1,win2,win3,blinkled,alarmled,seg,an,buzzer);

input clk;
input [7:0] pass; //password
input act, door, win1, win2, win3;
output reg blinkled=0, alarmled=0;
output [6:0] seg;
output [3:0] an;
output reg buzzer=1;

localparam AOFF=2'b00, AON=2'b01, PASSCHECK=2'b10, SOUND=2'b11;
reg [1:0] state=AOFF;

integer passcounter=0;
localparam secondtime=1; //1 second
  reg [7:0] seconds=0;
parameter password=8'h55; // initial password
reg [3:0]active=4'b0000;

wire [3:0] thos,huns,tens,ones;

binarytoBCD bin({4'b0000,seconds},thos,huns,tens,ones);
seven_segment_driver seg7 (clk,1'b0,tens,ones,4'b0000,active,seg,an);

always @ (posedge clk)
case(state)
AOFF:	
	if (act == 1) state <= AON;
AON:
	if (door != 0) state <= PASSCHECK; //if door open, goto password check
	else if ((win1 | win2 | win3) != 0) state <= SOUND; //if windows open, goto sound state
PASSCHECK:  
	if (passcounter == secondtime) 
	begin
        seconds <= seconds  + 1'b1;
        blinkled <= ~blinkled;
        passcounter <= 0;
	end
	else if (pass == password)  //if correct password, alarm goto off state
	begin 
        blinkled <= 0;         
        seconds <= 0;           
        state <= AOFF;
	end
	else if (seconds == 8'b00010100) //if 20 seconds pass, goto sound state
	begin
        blinkled <= 0;
        seconds <= 0;                      
        state <= SOUND;
	end
	else 
	   passcounter <= passcounter + 1;
SOUND:
	if (pass == password) //if correct password, alarm off
	begin
        alarmled <= 0;
        state <= AOFF;
        buzzer <= 1;
	end
	else 
	begin
        alarmled <= 1;
        buzzer <= 0;  //start buzzer
	end
endcase

always @ (posedge clk)
case (state)
AOFF:
	active <= 4'b0000;
AON:
	active <= 4'b1010;
endcase

endmodule
