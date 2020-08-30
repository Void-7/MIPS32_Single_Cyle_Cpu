module regfile(
    input clk,
    input rst,
    input we,   //write enable
    input [4:0] raddr1, //read addr1:Ra
    input [4:0] raddr2, //read addr2:Rb
    input [4:0] waddr,  //target addr:Rw
    input [31:0] wdata, //data to be written:busW
    
    output [31:0] rdata1,   //out1:busA
    output [31:0] rdata2    //out2:busB
);

reg [31:0] my_cell [31:0];      //registers 32*32
integer i;
always@(posedge clk or posedge rst) begin
    if(rst) begin
        for(i=0;i<32;i=i+1)
        begin
             my_cell[i]<=32'b0;
        end
    end else begin
        if(we&&waddr!=5'b0) my_cell[waddr]<=wdata;
    end
end

assign rdata1=my_cell[raddr1];
assign rdata2=my_cell[raddr2];

endmodule