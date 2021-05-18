//////////////////////////////////////////////////////////////////////////////////
// This module is designed to convert a binary bumber to a BCD number.
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1s / 1ms
module binarytoBCD(binary,thos,huns,tens,ones);

input [11:0] binary;
output reg [3:0] thos,huns,tens,ones;

reg [11:0] temp;

always @ (binary)
begin
    temp = binary;    
    thos = temp/1000;
    temp = temp%1000;
    huns = temp/100;
    temp = temp%100;
    tens = temp/10;
    temp = temp%10;
    ones = temp;    
end

endmodule
