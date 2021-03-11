`timescale 1ns / 1ps 
// clk is 100 mhz
module pulsegenerator(
input clk,
input [1:0] mode,
input start,
output pulse
);

reg [8:0] pulsemode = 0;
wire gen;
wire sec;
assign pulse = gen;
clkdiv pulsemaker(clk,pulsemode,gen);
clkdiv second(clk,9'd1,sec);
reg[8:0] counter = 0;


always@(posedge sec)
begin
    if(start)
        begin
            case(mode)
            2'b00: pulsemode = 32;
            
            2'b01: pulsemode = 64;
            
            2'b10: pulsemode = 128;
            
            2'b11: begin
            if(counter == 9'd0)
                pulsemode = 20;
            else
            if(counter == 9'd1)
                pulsemode = 33;
            else
            if(counter == 9'd2)
                pulsemode = 66;
            else
            if(counter == 9'd3)
                pulsemode = 27;
            else
            if(counter == 9'd4)
                pulsemode = 70;
            else
            if(counter == 9'd5)
                pulsemode = 30;
            else
            if(counter == 9'd6)
                pulsemode = 19;
            else
            if(counter == 9'd7)
                pulsemode = 30;
            else
            if(counter == 9'd8)
                pulsemode = 33;
            else
            if(9'd9 <= counter <= 9'd72)
                pulsemode = 69;
            else
            if(9'd73 <= counter <= 9'd78)
                pulsemode = 34;
            else
            if(9'd79 <= counter <= 9'd143)
                pulsemode = 124;
            else
            if (counter >= 9'd145)
                pulsemode = 0;
                
            end
                   
        endcase
    end
    counter = counter +1;
end



endmodule