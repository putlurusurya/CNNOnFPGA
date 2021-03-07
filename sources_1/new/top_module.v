
module top_module#(
    parameter array_size = 9 ,
    parameter data_size=16,
    parameter weight_size=data_size*array_size*array_size,
    parameter mac_size=data_size*array_size,
    parameter dim_data_size=16
    )(
    input s_clk,
    input w_clk,
    input reset,
    input enable,
    input [7:0] initial_instruction_address,
    input [dim_data_size-1:0] number_instrs,
    
    output [mac_size-1:0] max_pool_output1
    
    
    );
    
    
    wire [mac_size-1:0] macout;
    wire done;
    wire w_done;
    wire [mac_size-1:0] relu_out;
    
    wire [weight_size-1:0] weightin;
    wire [array_size-1:0] bias_done;
    wire [mac_size-1:0] buffer_in;
    wire [array_size*data_size-1:0] buffer_out;
    wire [13:0] maxpool_addr_out;
    
    wire [14*array_size-1:0] buff_fill_address;
    wire [mac_size-1:0] systolic_dataout;
    wire [array_size-1:0] buff_write_enable_out;
    
    //fifo parameters
    wire [13:0] fifo_initial_address;
    wire [13:0] c_address;
    wire [dim_data_size-1:0] image_height;
    wire [dim_data_size-1:0] image_width;
    wire [dim_data_size-1:0] Weight_size;
    wire [7:0] fifo_offset;
    wire [array_size-1:0] fifo_w_en;
    wire [array_size-1:0] fifo_r_en;
    wire [array_size-1:0] full;
    wire [array_size-1:0] empty;
    wire fifo_fill_done;
    wire fifo_fill_enable;
    wire fifo_fill_reset;
    
    
    //weight fill parameters
    wire w_reset;
    wire weight_write_enable;
    wire [14:0] weight_initial_address;
    wire [dim_data_size-1:0] number_filters;
    
    
    wire [array_size-1:0] relu_enable;
    wire [array_size-1:0] buffer_fill_enable;
    wire [array_size-1:0] buffer_fill_reset;
    wire [array_size-1:0] buffer_fill_done;
    wire [13:0] buffer_fill_initial_address;
        
    wire [data_size-1:0] systolic_datain;
    
    wire [data_size*array_size-1:0] bias_added;
    wire [mac_size-1:0] relu  ;
    
    wire [array_size-1:0] maxPoolingDone;
    //demux parameters
    wire [mac_size-1:0] sigmoid;
    
    wire [mac_size-1:0] d3;
    wire [mac_size-1:0] d4;
    
    wire [3:0] demux_sel;
    
    

    
    wire [dim_data_size-1:0] output_featuremapsize;
    
    
    wire [13:0] maxpool_fill_initial_address;
    wire maxpool_fill_reset;
    wire  maxpool_fill_enable;
    wire  maxpool_done;
    
    reg [array_size-1:0] is_empty=0;
    
    wire maxpool_clear;
    wire [array_size-1:0] maxpool_arr_r_en;
    wire [array_size-1:0] maxpool_arr_enable;
    
    wire [array_size-1:0] bias_enable;
    wire bias_reset;

    
    master_control mc(
    
    .clk(s_clk),
    .reset(reset),  
    .enable(enable),
    .number_instrs(number_instrs),
    .initial_instruction_address(initial_instruction_address),
    
    //Set1 Fifo fill control and fifo signals
    .fifo_r_en(fifo_r_en),
    .fifo_clear(fifo_clear),
    
    .fifo_initial_address(fifo_initial_address),
    .fifo_fill_enable(fifo_fill_enable),
    .fifo_fill_reset(fifo_fill_reset),
    .image_height(image_height),
    .image_width(image_width),
    .fifo_offset(fifo_offset),
    .fifo_fill_done(fifo_fill_done),
    
    //systolic array control signals
    .s_reset(s_reset),
    
    //weight fill contrl signals
    .weight_initial_address(weight_initial_address),
    .w_reset(w_reset),
    .weight_write_enable(weight_write_enable),
    .Weight_size(Weight_size),
    .number_filters(number_filters),
    .w_done(w_done),
    
    //Bias adder signals
    .bias_reset(bias_reset),
    .bias_enable(bias_enable),
    .bias_done(bias_done),
    
    //demux
    .demux_sel(demux_sel),
    
    //relu array
    .relu_enable(relu_enable),
    
    //buffer fill
    .buffer_fill_enable(buffer_fill_enable),
    .buffer_fill_reset(buffer_fill_reset),
    .buffer_fill_initial_address(buffer_fill_initial_address),
    .output_featuremapsize(output_featuremapsize),
    .buffer_fill_done(buffer_fill_done),
    
    //maxpoolfill
    .maxpool_fill_reset(maxpool_fill_reset),
    .maxpool_fill_enable(maxpool_fill_enable),
    .maxpool_done(maxpool_done),
    .maxpool_fill_initial_address(maxpool_fill_initial_address),
    
    //maxpool array
    .maxpool_clear(maxpool_clear),
    .maxpool_arr_r_en(maxpool_arr_r_en),
    .maxpool_arr_enable(maxpool_arr_enable),
    
    .done(done)

    );
    
    
    wire [array_size-1:0] fifo_full;
    
    fifo_fill_control_2 f_c(
        .clk(w_clk),
        .initial_address(fifo_initial_address),
        .write_enable_in(fifo_full),
        .enable(fifo_fill_enable),
        .reset(fifo_fill_reset),
        .weight_size(Weight_size),
        .image_height(image_height),
        .image_width(image_width),
        .c_address(c_address),
        .write_enable_out(fifo_w_en),
        .completed(fifo_fill_done),
        .offset(fifo_offset)
    );
    
    InputDataROM InputROM (
       .clka(w_clk),    
       .addra(c_address), 
       .douta(systolic_datain)  
    );
    wire [array_size-1:0] fifo_empty;
    fifo_array input_f_arr(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(fifo_r_en),
        .w_en(fifo_w_en),
        .rclear(fifo_clear),
        .wclear(fifo_clear),
        .full(fifo_full),
        .empty(fifo_empty),
        .in_bus(systolic_datain),
        .out_bus(systolic_dataout)
     ); 
     
    weight_fill_control wfc(
        .clk(w_clk),
        .initial_address(weight_initial_address),
        .enable(weight_write_enable),
        .reset(w_reset),
        .weight_size(Weight_size),
        .done(w_done),
        .number_filters(number_filters),
        .weight_out(weightin)
    );
    
    systolic_array s_ar(
        .clk(s_clk),
        .reset(s_reset),
        .datain(systolic_dataout),
        .weightin(weightin),
        .macout(macout)
        );

    //bias_adder parameter
     reg [data_size*array_size-1:0] biases=0;
     
     reg mode=1;
     
     
    Bias_adder bias_adder(
        .clk(s_clk),
        .reset(bias_reset),
        .enable(bias_enable),
        .macout(macout),
        .biases(biases),
        .added_output(bias_added),
        .done(bias_done)
        );
        
    demux_array demux_arr(
        .sel(demux_sel),
        .d_in(bias_added),
        .d_out_1(sigmoid),
        .d_out_2(relu),
        .d_out_3(d3),
        .d_out_4(d4)
    );
  
    reluArr rarr(
        .clk(s_clk),
        .en(relu_enable),
        .in(relu),
        .out0(relu_out)
    );
    
    
    buffer_fill_array buffer_fill_arr(
        .w_clk(s_clk),
        .enable(buffer_fill_enable),
        .reset(buffer_fill_reset),
        .initial_address(buffer_fill_initial_address),
        .output_featuremapsize(output_featuremapsize),
        .is_empty(is_empty),
        .c_address(buff_fill_address),
        .write_enable(buff_write_enable_out),
        .done(buffer_fill_done)
    );
    
    reg [array_size-1:0] buffer_ena=9'h1ff;
    reg [array_size-1:0] buffer_enb=9'h1ff;
    
    wire [3:0] maxpool_sel;
    
    max_pool_fill mpf(
                .clk(w_clk),
                .reset(maxpool_fill_reset),
                .enable(maxpool_fill_enable),
                .add_out(maxpool_addr_out),
                .add_in(maxpool_fill_initial_address),
                .sel(maxpool_sel),
                .done(maxpool_done)
            );
    
  
    
    
    BufferRamArray unified_buffer (
         .w_clk(s_clk),      
         .wea(buff_write_enable_out),      
         .addra(buff_fill_address),  
         .dina(relu_out),   
         .r_clk(w_clk),         
         .addrb(maxpool_addr_out),  
         .bus2(buffer_out)
    );
    wire [4*array_size-1:0] maxpool_full;
    wire [4*array_size-1:0] maxpool_empty;
    maxpool_array maxpool_array(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(maxpool_arr_r_en),
        .full(maxpool_full),
        .empty(maxpool_empty),
        .data_in(buffer_out),
        .sel(maxpool_sel),
        .clear(maxpool_clear),
        .maxPoolingDone(maxPoolingDone),
        .output1(max_pool_output1),
        .enable(maxpool_arr_enable)
    );
    
    
    
endmodule
