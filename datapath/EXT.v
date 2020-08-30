/*signed extension*/
module s_ext(
    input [15:0] in,
    output [31:0] out
);

wire signed [31:0]S={{16{in[15]}},in};
assign out=S;

endmodule

/*zero extension*/
module z_ext(
    input [15:0] in,
    output [31:0] out
);

wire unsigned [31:0]Z={16'b0,in};
assign out=Z;

endmodule