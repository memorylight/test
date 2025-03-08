module tb_hello(output [31:0]cnt,
                input clk
);
    initial $dumpvars(0, tb_hello);  // 指定要导出哪些信号的波形！！这里导出了 tb_hello 内的所有信号
    
  	reg clk=1'b1;                    // 时钟
  	always #10000 clk = ~clk;
    
    reg [31:0] cnt = 0;
code1 code1();
 always @ (posedge clk)
        if(cnt < 5) begin            // 计数器cnt从0计数到5
            cnt <= cnt + 1;
        end else begin               // 计数到5后退出仿真
            $display("hello world");
            $finish;
        end
endmodule