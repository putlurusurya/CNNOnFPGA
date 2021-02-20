`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2021 10:44:32
// Design Name: 
// Module Name: Buffer_fill_control
// Project Name: 
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

module output_fill (
	input w_clk,
	input enable,
	input reset,
	input initial_address,
	input [7:0] output_featuremapsize,
	input is_empty,
	output reg c_address,
	output reg write_enable,
	output reg read_enable
	);
	
	
	
	reg temp_address;
		
		
			
        always @(posedge w_clk or negedge reset)begin
                if(~reset)
                    begin
                        read_enable = 0;
                        write_enable =0;
                    end
                else if(enable)
                    begin
                        temp_address = initial_address;
                        if(temp_address - initial_address <= output_featuremapsize)
                            begin
                                write_enable = 0;
                                read_enable = 0;
                            end
                            
                        else
                            begin
                                write_enable = 1;
                                read_enable = 1;
                                c_address = temp_address;
                            end
                    end         
                else
                    begin
                    
                    read_enable = 0;
                    write_enable =0;
                    
                    end
                    
        end
        
endmodule
