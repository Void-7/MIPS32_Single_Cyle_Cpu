module MUX(
    input[31:0]a,
    input[31:0]b,
    input switch,
    
    output reg[31:0]out
);

always@(*) begin
    if(switch)
        out<=b;
    else 
        out<=a;
end

endmodule

module MUX_3src_5bit(
    input[4:0]a,
    input[4:0]b,
    input[4:0]c,
    input b_enable,
    input c_enable,
    
    output reg[4:0]out
);

always@(*) begin
    if(b_enable)
        out<=b;
    else if(c_enable)
        out<=c;
    else out<=a;
end

endmodule