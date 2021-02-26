
module top_module#(
    parameter array_size = 9 ,
    parameter data_size=16,
    parameter weight_size=data_size*array_size*array_size,
    parameter mac_size=data_size*array_size,
    parameter dim_data_size=16
    )(
    input s_clk,
    input w_clk,
    input s_reset,
    input w_reset,
    input enable
    );
    //fifo parameters
    reg [19:0] fifo_initial_address=0;
    wire [19:0] c_address;
    reg [dim_data_size-1:0] image_height=5;
    reg [dim_data_size-1:0] image_width=5;
    reg [dim_data_size-1:0] Weight_size=3;
    reg [dim_data_size-1:0] offset=0;
    wire [array_size-1:0] fifo_w_en;
    wire [array_size-1:0] full;
    wire [array_size-1:0] empty;
    wire fifo_fill_done;
    wire [array_size-1:0] r_en;
    wire clear;
    wire reset;
    
    //weight fill parameters
    reg [13:0] w_initial_address=0;
    reg [dim_data_size-1:0] number_filters=1;
    wire  [weight_size-1:0] weightin;
    wire w_done;
    wire weight_write_enable;
    
    wire [data_size*array_size-1:0] systolic_dataout;
    wire [data_size-1:0] systolic_datain;
    wire [mac_size-1:0] macout;
    
    
    //demux parameters
    wire [mac_size-1:0] sigmoid;
    wire [mac_size-1:0] relu;
    wire [mac_size-1:0] d3;
    wire [mac_size-1:0] d4;
    
    reg [1:0] sel=2'b01;
    
    wire [mac_size-1:0] buffer_in;
    reg [array_size-1:0] relu_enable;
    reg [array_size-1:0] buffer_write_enable;
    wire [mac_size-1:0] relu_out;
    
    fifo_fill_control_2 f_c(
        .clk(w_clk),
        .initial_address(fifo_initial_address),
        .write_enable_in(full),
        .enable(enable),
        .reset(reset),
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
    
    fifo_array input_f_arr(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .w_en(fifo_w_en),
        .clear(clear),
        .full(full),
        .empty(empty),
        .in_bus(systolic_datain),
        .out_bus(systolic_dataout)
     ); 
     
    weight_fill_control wfc(
        .clk(w_clk),
        .initial_address(w_initial_address),
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
     wire [data_size*array_size-1:0] bias_added;
     reg mode=1;
     reg [array_size-1:0] bias_enable=9'h1ff;
     
    Bias_adder bias_adder(
        .clk(s_clk),
        .reset(bias_reset),
        .mode(mode),
        .enable(bias_enable),
        .macout(macout),
        .biases(biases),
        .added_output(bias_added),
        .done(bias_done)
        );
        
    demux_array demux_arr(
        .sel(sel),
        .d_in(bias_added),
        .d_out_1(sigmoid),
        .d_out_2(relu),
        .d_out_3(d3),
        .d_out_4(d4)
    );
  
    reluArr rarr(
        .clk(w_clk),
        .en(enable),
        .in(relu),
        .out0(relu_out)
    );
    
    fifo_array_2 relu_fifoarr(
        .r_clk(r_clk),
        .w_clk(w_clk),
        .r_en(relu_r_en),
        .w_en(relu_w_en),
        .clear(relu_clear),
        .full(relu_full),
        .empty(relu_empty),
        .dataIn(relu_out),
        .dataOut(buffer_in)
         );
    
    buffer_fill_array buffer_fill_arr(
        .w_clk(w_clk),
        .enable(buffer_fill_enable),
        .reset(buffer_fill_reset),
        .initial_address(buffer_fill_initial_address),
        .output_featuremapsize(output_featuremapsize),
        .is_empty(is_empty),
        .c_address(buff_fill_address),
        .write_enable(buff_write_enable_out),
        .done(buffer_fill_done)
    );
    
    BufferRamArray unified_buffer (
         .clka(w_clk),    
         .ena(buffer_ena),      
         .wea(buff_write_enable_out),      
         .addra(buff_fill_address),  
         .dina(buffer_in),   
         .clkb(r_clk),    
         .enb(buffer_enb),      
         .addrb(maxpool_add_out),  
         .doutb(buffer_out)  
    );
    
    maxpool_fill_control_array mpfc_arr(
        .clk(w_clk),
        .reset(reset),
        .add_out(maxpool_add_out),
        .add_in(add_in),
        .sel(sel),
        .done(done)
    );
    
    maxpool_array maxpool_array(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .full(maxpool_full),
        .empty(maxpool_empty),
        .data_in(buffer_out),
        .sel(maxpool_sel),
        .clear(maxpool_clear),
        .maxPoolingDone(maxPoolingDone),
        .output1(max_pool_output1),
        .enable(enable)
    );
    
    
endmodule
