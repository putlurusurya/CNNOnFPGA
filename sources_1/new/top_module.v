
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
    input s_reset,
    input w_reset,
    input clear,
    input enable,
    input weight_write_enable,
    output [mac_size-1:0] relu_out,
    input [array_size-1:0] r_en,
    output done,
    output w_done,
    output [mac_size-1:0] macout,
    output [weight_size-1:0] weightin

    );
    
    
    reg [19:0] initial_address=0;
    wire [19:0] c_address;
    reg [13:0] w_initial_address=0;
    reg [dim_data_size-1:0] Weight_size=3;
    reg [dim_data_size-1:0] number_filters=1;
    reg [dim_data_size-1:0] image_height=5;
    reg [dim_data_size-1:0] image_width=5;
    reg [dim_data_size-1:0] offset=0;
    wire [data_size*array_size-1:0] dataout;
    wire [data_size-1:0] datain;
    wire [array_size-1:0] w_en;
    wire [array_size-1:0] full;
    wire [array_size-1:0] full_o;
    wire [array_size-1:0] empty;
    wire [array_size-1:0] empty_o;
    wire [mac_size-1:0] sigmoid;
    wire [mac_size-1:0] relu;
    wire [mac_size-1:0] d3;
    wire [mac_size-1:0] d4;
    reg [1:0] sel=2'b01;
    
    wire [mac_size-1:0] buffer_in;
    reg [array_size-1:0] relu_enable;
    reg [array_size-1:0] buffer_write_enable;
  
    
    fifo_fill_control_2 f_c(
        .clk(w_clk),
        .initial_address(initial_address),
        .write_enable_in(full),
        .enable(enable),
        .reset(reset),
        .weight_size(Weight_size),
        .image_height(image_height),
        .image_width(image_width),
        .c_address(c_address),
        .write_enable_out(w_en),
        .completed(done),
        .offset(offset)
        );
    InputDataROM InputROM (
      .clka(w_clk),    
      .addra(c_address), 
      .douta(datain)  
    );
    fifo_array input_f_arr(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .w_en(w_en),
        .clear(clear),
        .full(full),
        .empty(empty),
        .in_bus(datain),
        .out_bus(dataout)
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
        .datain(dataout),
        .weightin(weightin),
        .macout(macout)
        );
    Bias_adder(
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
    
    maxpool_array uut(
        .r_clk(s_clk),
        .w_clk(w_clk),
        .r_en(r_en),
        .full(maxpool_full),
        .empty(maxpool_empty),
        .data_in(buffer_data_in),
        .sel(maxpool_sel),
        .clear(maxpool_clear),
        .maxPoolingDone(maxPoolingDone),
        .output1(max_pool_output1),
        .enable(enable)
    );
    
    

endmodule
