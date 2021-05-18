`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// College: Netaji Subhas University of Technology 
// Engineer: Yash Gupta 
// 
// Create Date: 16.05.2021 18:45:58
// Design Name: 
// Module Name: home_alarm_topmodule
// Project Name: Home alarm system
// Target Devices: Xilinx Artix 7 FPGA board
// Tool Versions: 
// Description: Verilog description of a home alarm system.
//              This is the top module of our project. It contains other modules and
//              make our Project work. We can also use sensors for internal security
//              in place of input from windows.
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module home_alarm_topmodule(clk,sw,btnC,btnU,btnD,btnR,btnL,led,seg,an,JA);

input clk;
input [7:0] sw; //for password
input btnC, btnU; //C for activation & U represnts the door
input btnD,btnL,btnR; //windows
output [1:0] led;
output [6:0] seg;
output [3:0] an;
output [0:0] JA; //buzzer

//We don't need debouncing for simultion purpose, we would need it while implementing it on FPGA
//wire btnCclr,btnUclr,btnDclr,btnRclr,btnLclr;

//debounce dbnC(clk,btnC,btnCclr);
//debounce dbnU(clk,btnU,btnUclr);
//debounce dbnD(clk,btnD,btnDclr);
//debounce dbnL(clk,btnL,btnLclr);
//debounce dbnR(clk,btnR,btnRclr);

home_alarm Home_Alarm (clk,sw,btnC,btnU,btnD,btnR,btnL,led[1],led[0],seg,an,JA);



endmodule
