module im_tb;
reg [11:2]addr;
wire[31:0]dout;

im_4k im(addr,dout);

initial begin
    addr=10'b0;
end

always #10 addr=addr+1;

endmodule