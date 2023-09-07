module UART_rx(
    input             msg_in_rx,
    input             clk_rx,
    input             rst_n_rx,
    output [14:0]     msg_out_rx
);
    reg [14:0] msg_o;
    reg [16:0] msg;
    reg        enable;
    reg [4:0]  counter;

    always@(posedge clk_rx or negedge rst_n_rx) begin
        if (!rst_n_rx) begin
           counter <= 0;
        end
        else if (counter == 17)begin
            counter <= 0;
        end
        else if (enable == 1)
            counter <= counter + 1;
    end

    always@(msg_in_rx,counter,rst_n_rx)begin
        if (!rst_n_rx)
            enable = 0;
        else if (counter == 17)
            enable = 0;
        else if (msg_in_rx == 0)
            enable = 1;
        else enable = enable;
    end

    always@(posedge clk_rx or negedge rst_n_rx)begin
        if (!rst_n_rx) begin
            msg     <= 17'b 11111111111111111;
            msg_o   <= 15'b 111111111111111;
        end
        else if (counter == 17) begin
            msg_o   <= msg [15:1];
            msg     <= 17'b 11111111111111111;
        end
        else if (enable == 1) begin
            msg [16-counter] <= msg_in_rx;
        end
    end

    assign msg_out_rx = msg_o;
endmodule
