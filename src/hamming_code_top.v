module hamming_code_encoder_top(
    input   wire [10:0] msg_in_en, 
    input   wire        rst_n_en,
    input               enable_en,
    input               clk_en,
    output  wire        msg_out_en
);
    wire [14:0] coder2UART;

    hamming_code_encoder F1 (
        .msg_in_coder (msg_in_en),
        .msg_out_coder(coder2UART),
        .rst_n_coder(rst_n_en)
        );

    UART_tx U1 (
        .msg_in_tx(coder2UART),
        .msg_out_tx(msg_out_en),
        .enable_tx(enable_en),
        .clk_tx(clk_en),
        .rst_n_tx(rst_n_en)
    );
endmodule
