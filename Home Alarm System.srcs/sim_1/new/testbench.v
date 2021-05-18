//////////////////////////////////////////////////////////////////////////////////
// This is the testbench for our Home alarm system project
// It is used fir simulations
//////////////////////////////////////////////////////////////////////////////////

`timescale 1s / 1ms

module home_alarm_topmodule_tb;
    
reg clk,btnC,btnD,btnL,btnR,btnU;
reg [7:0] sw;
wire [1:0] led;
wire [6:0] seg;
wire [3:0] an;
wire [0:0] JA;	

home_alarm_topmodule DUT (clk,sw,btnC,btnU,btnD,btnR,btnL,led,seg,an,JA);

initial begin
    clk = 0;
    forever
        #5 clk = ~clk;         
end

initial begin
    
    sw=8'b00000000;btnC=0;btnL=0;btnR=0;btnD=0;btnU=0;
    #10 btnC = 1;
    
//    //Testing Door
//    #10 btnU = 1;
//    #10 sw=8'b00001111;
//    #500 sw=8'b01010101;
//    //Working Coreectly
    
//    //Testing Windows  
    #10 btnL=1;
    #10 sw=8'b111111110;
    #50;
    #50 sw=8'b01010101;
//    //Working Correctly

    #100 $finish;
end

initial begin
  $display("\t\t\t\t time \tclk  sw  \tbtnC \tbtnU \tbtnD \tbtnR \tbtnL \tled \tseg \tan     \tJA");
  $monitor($time,"\t%b  %8b \t%b \t\t%b \t\t%b \t\t%b \t\t%b \t%b \t%7b \t%4b \t%b", clk,sw,btnC,btnU,btnD,btnR,btnL,led,seg,an,JA);
  $dumpfile("simulation_waveform.vcd");
  $dumpvars(0,home_alarm_topmodule_tb);
end
  
endmodule 

  