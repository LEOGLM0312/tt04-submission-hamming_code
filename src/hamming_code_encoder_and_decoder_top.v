module tt_um_LEOGLM_hamming_code_top #( parameter MAX_COUNT = 10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    reg [10:0] msg_in_en; 
    reg        enable_en;
    wire        msg_out_en;

    reg        msg_in_de; 
    reg        rst_n_de;
    reg        clk_de;
    wire [10:0] msg_out_de;

    reg [7:0] uo_out_reg;
    reg [7:0] uio_out_reg;
    reg [7:0] uio_oe_reg;

    reg         state;          //switch mode: 0:encoder 1:decoder

    hamming_code_encoder_top A1(
        .msg_in_en(msg_in_en),
        .rst_n_en(rst_n),
        .enable_en(enable_en),
        .clk_en(clk),
        .msg_out_en(msg_out_en)
    );
    
    hamming_code_decoder_top B1(
        .msg_in_de(msg_in_de),
        .rst_n_de(rst_n),
        .clk_de(clk),
        .msg_out_de(msg_out_de)
    );

    always@(posedge ui_in[0] or negedge rst_n) begin
        uio_out_reg[7:5] <= 3'b 000;
        if (rst_n == 0)
            state <= 0;
        else 
            state <= ~state;
    end

    always@(*) begin
        if (state==0) begin
            uo_out_reg[0] = 0;  //state: encoder
            uio_oe_reg    = 8'b00000000;
            enable_en     = ui_in[1];
            msg_in_en     = {ui_in[7:3],uio_in[5:0]};
            uo_out_reg[1] = msg_out_en;
        end
        else begin
            uo_out_reg[0]                         = 1;  //state:decoder
            uio_oe_reg                            = 8'b11111111;
            msg_in_de                             = ui_in[2];
            {uo_out_reg[7:2],uio_out_reg[4:0]}    = msg_out_de;
        end
    end
    assign uo_out = uo_out_reg;
    assign uio_out= uio_out_reg;
    assign uio_oe = uio_oe_reg;
endmodule

