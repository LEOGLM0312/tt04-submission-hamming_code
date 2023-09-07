module UART_tx(
    input  [14:0]  msg_in_tx, //From encoder
    input          enable_tx,
    input          clk_tx,
    input          rst_n_tx,
    output         msg_out_tx
);
    reg [16:0] msg;

    always@(posedge clk_tx or negedge rst_n_tx) begin
        if (!rst_n_tx) begin                    //reset
            msg [0] <= 1'b1; 
            msg [15:1] <= 15'b0;
            msg [16] <= 1'b1;
        end
        else if (enable_tx == 1)                //load message from encoder
            msg <= {1'b0,msg_in_tx,1'b1};       //add start bit and stop bit
        else begin
            msg [16:0] <= {msg [15:0], 1'b1};   //shift upon clk rises
        end
    end
    assign msg_out_tx = msg [16];               //output msg one by one
endmodule
