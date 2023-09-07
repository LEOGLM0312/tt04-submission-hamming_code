module hamming_code_decoder_top(
    input               msg_in_de, 
    input               rst_n_de,
    input               clk_de,
    output    [10:0]    msg_out_de
);
    wire [14:0] UART2decoder;

    hamming_code_decoder F1 (        
        .msg_in_decoder(UART2decoder),
        .msg_out_decoder (msg_out_de),
        .rst_n_decoder(rst_n_de),
        .clk_decoder(clk_de)
        );

    UART_rx U1 (
        .msg_in_rx(msg_in_de),
        .msg_out_rx(UART2decoder),
        .rst_n_rx(rst_n_de),
        .clk_rx(clk_de)
    );
endmodule
