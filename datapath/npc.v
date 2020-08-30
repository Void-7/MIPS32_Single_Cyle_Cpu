module npc(
    input [31:0] cur_pc,    //pc
    input [31:0] pc_next,   //pc+4
    input [31:0] br_offset_words, //branch offset*4
    input [25:0] instruction,//for jmp_pc_addr
    input [31:0] ALUresult,//for jr_pc_addr
    input jmp,jr,jalr,
    input Branch,zero,nBranch,BGEZ,BGTZ,BLEZ,BLTZ,
    
    output reg[31:0] jr_pc_addr
);

wire br_ctr;
reg[31:0] br_out;
wire[31:0] br_offset;
wire[31:0] bj_mux_result;
wire[31:0] jmp_pc_addr;
wire bgez,blez,bgtz,bltz;

assign br_offset=br_offset_words<<2;

//br-type inst.
assign br_ctr=((Branch&zero&!nBranch&&!BGEZ&&!BGTZ&&!BLEZ&&!BLTZ)||(nBranch&&!zero)||bgez||bgtz||blez||bltz)?1'b1:1'b0;
always@(*) begin
    if(br_ctr) br_out<=cur_pc+br_offset;
    else br_out<=pc_next;
end
assign bgez=(BGEZ==1)?ALUresult[0]:1'b0;
assign bgtz=(BGTZ==1)?ALUresult[0]:1'b0;
assign blez=(BLEZ==1)?ALUresult[0]:1'b0;
assign bltz=(BLTZ==1)?ALUresult[0]:1'b0;

//add base-addr for jmp/jal inst
wire[25:0]inst;
assign inst=instruction[25:0]+26'b00_0000_0000_0000_1100_0000_0000;

//jmp-type inst.
assign jmp_pc_addr=(jmp==1)?{cur_pc[31:28],inst[25:0],2'b00}:32'b0;
MUX bj_mux(br_out,jmp_pc_addr,jmp,bj_mux_result);
always@(*) begin
    if(jr==1||jalr==1) jr_pc_addr<=ALUresult;
    else jr_pc_addr<=bj_mux_result;
end
endmodule