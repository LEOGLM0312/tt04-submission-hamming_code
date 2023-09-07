module hamming_code_decoder(
    input   [14:0] msg_in_decoder, //From UART receiver
    input          clk_decoder,
    input          rst_n_decoder,
    output  [10:0] msg_out_decoder //corrected msg
);
    reg e1; // 1: error in the coverage of parity bit 1  0: no error 
    reg e2;
    reg e3;
    reg e4;

    reg [3:0]  error;
    reg [14:0] msg ;

    always@(*) begin
        if (!rst_n_decoder) begin
            e1 = 0;
            e2 = 0;
            e3 = 0;
            e4 = 0;
        end
        else begin
            e1 = (msg_in_decoder[14]+msg_in_decoder[10]+msg_in_decoder[9]+msg_in_decoder[7]+msg_in_decoder[6]+msg_in_decoder[4]+msg_in_decoder[2]+msg_in_decoder[0])  %2;
            e2 = (msg_in_decoder[13]+msg_in_decoder[10]+msg_in_decoder[8]+msg_in_decoder[7]+msg_in_decoder[5]+msg_in_decoder[4]+msg_in_decoder[1]+msg_in_decoder[0])  %2;
            e3 = (msg_in_decoder[12]+msg_in_decoder[9]+msg_in_decoder[8]+msg_in_decoder[7]+msg_in_decoder[3]+msg_in_decoder[2]+msg_in_decoder[1]+msg_in_decoder[0])  %2;
            e4 = (msg_in_decoder[11]+msg_in_decoder[6]+msg_in_decoder[5]+msg_in_decoder[4]+msg_in_decoder[3]+msg_in_decoder[2]+msg_in_decoder[1]+msg_in_decoder[0])  %2;
            msg = {msg_in_decoder[14],msg_in_decoder[13],msg_in_decoder[10],msg_in_decoder[12],msg_in_decoder[9:7],msg_in_decoder[11],msg_in_decoder[6:0]};

            error = {e1,e2,e3,e4}; //position of the error

            msg[15-error] = ~msg[15-error]; //correct the error
        end
    end

    assign msg_out_decoder = {msg[12],msg[10:8],msg[6:0]};
endmodule