module ext_tb;
reg [15:0]a,b;
wire[31:0]out1,out2;

s_ext se(a,out1);
z_ext ze(b,out2);

initial begin
    a=16'b0;b=16'b0;
    #10 a=16'hfffc;b=16'h010d;
    #10 a=16'h8000;b=16'h8000;
end

endmodule