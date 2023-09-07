module hamming_code_encoder(
    input   [10:0]  msg_in_coder, 
    input           rst_n_coder,
    output  [14:0]  msg_out_coder  //msg_in_coder & 4 parity bits
);
    reg p1; //paritybit 1
    reg p2; //paritybit 2
    reg p3; //paritybit 3
    reg p4; //paritybit 4
    reg [14:0] coded_msg; 

    always@(*) begin
        if (!rst_n_coder) begin
            p1 = 0;
            p2 = 0;
            p3 = 0;
            p4 = 0;
        end
        else begin
            p1 = (msg_in_coder[10]+msg_in_coder[9]+msg_in_coder[7]+msg_in_coder[6]+msg_in_coder[4]+msg_in_coder[2]+msg_in_coder[0])  %2;
            p2 = (msg_in_coder[10]+msg_in_coder[8]+msg_in_coder[7]+msg_in_coder[5]+msg_in_coder[4]+msg_in_coder[1]+msg_in_coder[0])  %2;
            p3 = (msg_in_coder[9]+msg_in_coder[8]+msg_in_coder[7]+msg_in_coder[3]+msg_in_coder[2]+msg_in_coder[1]+msg_in_coder[0])  %2;
            p4 = (msg_in_coder[6]+msg_in_coder[5]+msg_in_coder[4]+msg_in_coder[3]+msg_in_coder[2]+msg_in_coder[1]+msg_in_coder[0])  %2;
            coded_msg = {p1,p2,p3,p4,msg_in_coder};
        end
    end
    assign msg_out_coder = coded_msg;
endmodule
