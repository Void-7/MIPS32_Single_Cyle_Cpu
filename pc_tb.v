module pc_tb;

reg clk,rst;
wire[31:0] npc;
wire[31:0] cpc;
PC pc(clk,rst,npc,cpc);
assign npc=cpc+4;

initial begin
    clk<=0;rst<=1;
    #6 rst<=0;
end

always #5 clk=~clk;

endmodule