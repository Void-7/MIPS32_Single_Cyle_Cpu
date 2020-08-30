module PC(
    input clk,
    input rst,
    input [31:0]input_data,
    output reg[31:0]output_data
);

always@(posedge clk or posedge rst)begin
    if(rst) output_data<=32'h00003000;
    else begin
        output_data<=input_data;
    end
end

endmodule