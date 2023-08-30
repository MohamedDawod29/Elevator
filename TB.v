
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Mabrouk Dawod
// 
// Create Date: 08/30/2023 
// Design Name: 
// Module Name: elevator_TB
// Project Name: elevator
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module elevator_tb;
					  
					  reg clk;
					  reg reset_n;
					  reg [1:0] rfloor;
					  
					  wire [1:0] current_floor;
					  wire up, down, stop;
					  wire [6:0] counter;
					  
					  elevator dut (
						 .clk(clk),
						 .reset_n(reset_n),
						 .rfloor(rfloor),
						 .current_floor(current_floor),
						 .up(up),
						 .down(down),
						 .stop(stop),
						 .counter(counter)
					  );
					  
					  
					  always 
					  begin
						 #5 clk = ~clk;
					  end
					  
					  
					  initial 
					  begin
						 clk = 0;
						 reset_n = 0;
						 
						 #5 reset_n = 1; // Release reset
						 
						 // Test scenario 1: Going up to floor 1
						 rfloor = 2'b01;
						 #1000;
						 
						 // Test scenario 2: Going up to floor 3
						 rfloor = 2'b11;
						 #1000;
						 
						 // Test scenario 3: Going down to floor 2
						 rfloor = 2'b10;
						 #1000;
						 
						 // Test scenario 4: Going down to floor 0
						 rfloor = 2'b00;
						 #1000;
						 
						 // Test scenario 5: Going up to floor 1
						 rfloor = 2'b01;
						 #1000;
						 
						 // Test scenario 6: Going down to floor 0
						 rfloor = 2'b10;
						 #1000;
						 
						 $finish;
					  end
					  
  
endmodule
					