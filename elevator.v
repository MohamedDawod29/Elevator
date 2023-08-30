
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Mabrouk Dawod
// 
// Create Date: 08/30/2023 
// Design Name: 
// Module Name: elevator
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

module elevator 
					(
					input clk,reset_n,
					input [1:0] rfloor,
					output  [1:0] current_floor,
					output  up,down,stop,
					output [6:0] counter
					);
					
					reg [6:0] counter_next,counter_reg;
					reg [1:0] Q_next,Q_reg;
					reg up_next,up_reg;
					reg down_next,down_reg;
					reg stop_next,stop_reg;
					reg [1:0] floor_next,floor_reg;
					
					// states
					localparam s0 = 0,s1= 1,s2 = 2,s3 = 3;
					
					
					// present state
					always @ (posedge clk,negedge reset_n)
					begin
						if (~reset_n)
						begin
							Q_reg <= s0;
							floor_reg <= 2'b00;
							up_reg <= 0;
							down_reg <= 0;
							stop_reg <= 0;
							counter_reg <= 0;
						end
						else
						begin
							Q_reg <= Q_next;
							floor_reg <= floor_next;
							up_reg <= up_next;
							down_reg <= down_next;
							stop_reg <= stop_next;
							counter_reg <= counter_next;
						end
					end
					
					
					// next state
					always @ (*)
					begin
						Q_next = Q_reg;
						floor_next = floor_reg;
						up_next = up_reg;
						down_next = down_reg;
						stop_next = 1;
						counter_next = counter_reg;
							
						casez(Q_reg)
							s0:
							begin
								casez(rfloor)

								2'b01:
								begin
									if (counter_next == 29)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end

								2'b10:
								begin
									if (counter_next == 29)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end
								
								2'b11:
								begin
									if (counter_next == 29)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 89)
									begin
									Q_next = s3;
									floor_next = 2'b11;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end
								
								default:
								begin
									Q_next = s0;
									floor_next = 0;
									up_next = 0;
									down_next = 0;
									stop_next = 1;
									counter_next = 0;
								end
								
								endcase
							end
							
							s1:
							begin
								casez(rfloor)
								
								2'b00:
								begin
									if (counter_next == 29)
									begin
									Q_next = s0;
									floor_next = 2'b00;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end

								2'b10:
								begin
									if (counter_next == 29)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end
								
								2'b11:
								begin
									if (counter_next == 29)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s3;
									floor_next = 2'b11;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end
								
								default:
								begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 0;
									down_next = 0;
									stop_next = 1;
									counter_next = 0;
								end
								
								endcase

							end
							s2:
							begin
								casez(rfloor)
								
								2'b00:
								begin
									if (counter_next == 29)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s0;
									floor_next = 2'b00;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end

								2'b01:
								begin
									if (counter_next == 29)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end
								
								2'b11:
								begin
									if (counter_next == 29)
									begin
									Q_next = s3;
									floor_next = 2'b11;
									up_next = 1;
									down_next = 0;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									up_next = 1;
									stop_next = 0;
									end
								end
								
								default:
								begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 0;
									down_next = 0;
									stop_next = 1;
									counter_next = 0;
								end
								
								endcase	
							end
							s3:
							begin
								casez(rfloor)
								
								2'b00:
								begin
									if (counter_next == 29)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 89)
									begin
									Q_next = s0;
									floor_next = 2'b00;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end

								2'b01:
								begin
									if (counter_next == 29)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else if (counter_next == 59)
									begin
									Q_next = s1;
									floor_next = 2'b01;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end
								
								2'b10:
								begin
									if (counter_next == 29)
									begin
									Q_next = s2;
									floor_next = 2'b10;
									up_next = 0;
									down_next = 1;
									stop_next = 0;
									counter_next = 0;
									end
									else
									begin
									counter_next = counter_next + 1;
									down_next = 1;
									stop_next = 0;
									end
								end
								
								default:
								begin
									Q_next = s3;
									floor_next = 2'b11;
									up_next = 0;
									down_next = 0;
									stop_next = 1;
									counter_next = 0;
								end
								
								endcase		
							end
							default:
							begin
								Q_next = s0;
								floor_next = 2'b00;
								up_next = 0;
								down_next = 0;
								stop_next = 1;
								counter_next = 0;
							end
						endcase
					end
				
				// outputs
				assign current_floor = floor_reg;
				assign up = up_reg;
				assign down = down_reg;
				assign stop = stop_reg;
				assign counter = counter_reg;
							
endmodule
