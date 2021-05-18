//////////////////////////////////////////////////////////////////////////////////
// This module is made to control the debouncing of switches in order
// to eliminate any error that might be the result of debouncing.
// It uses delay between button taps to counter the issue.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1s / 1ms
module debounce(clk,btn,btn_clr);

input clk,btn;
output reg btn_clr;

parameter delay = 0.002; //20ms delay
integer count=0;

reg xnew=0;

always @(posedge clk)
if (btn != xnew) 
    begin 
        xnew <= btn; 
        count <= 0; 
    end
else if (count == delay) btn_clr <= xnew;
else count <= count + 1;

endmodule
