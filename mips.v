module mips(
    input clk,
    input rst
);

wire[31:0]instruction;
wire RegDST;
wire ALUSrc;
wire MemtoReg;
wire MemWrite;
wire RegWrite;
wire Branch;
wire nBranch;
wire Jmp;
wire jal;
wire Sftmd;
wire [4:0] shamt;
wire ExtOp;
wire [4:0]ALUop;
wire [4:0]wreg;
wire[31:0]wdata;
wire[31:0]rdata1;
wire[31:0]rdata2;
wire[31:0]extend;
wire[31:0]zextend;
wire[31:0]ext_result;
wire[4:0]aluc;
wire[31:0]aludata2;
wire[31:0]ALUresult;
wire zero;
wire carry;
wire overflow;
wire [31:0]next_pc;
wire [31:0]cur_pc;
wire[31:0]rdata;
wire[31:0] pc_plus4;
wire R_format;
wire[4:0]ALUctr;
wire[31:0] sign_ext_offset;
wire BGEZ,BGTZ,BLEZ,BLTZ;
wire lb,lbu;
wire jr,jalr;
wire [31:0] busW;
//pc
PC pc(clk,rst,next_pc[31:0],cur_pc[31:0]);
assign pc_plus4=cur_pc+4;
im_4k im(cur_pc[11:2],instruction[31:0]);

//npc
npc npc(cur_pc,pc_plus4,sign_ext_offset,instruction[25:0],ALUresult,Jmp,jr,jalr,
Branch,zero,nBranch,BGEZ,BGTZ,BLEZ,BLTZ,next_pc);
assign sign_ext_offset=(Branch==1)?extend:32'b0;

//imm ext(0:zero_ext 1:sign_ext)
s_ext sext(instruction[15:0],extend);
z_ext zext(instruction[15:0],zextend);
assign ext_result=(ExtOp==1)?extend:zextend;

//control
control ctl(instruction[31:26],instruction[20:16],
R_format,RegDST,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,nBranch
,BGEZ,BGTZ,BLEZ,BLTZ,lb,lbu,sb,jal,Jmp,ExtOp,ALUop[4:0]);
assign ALUctr=(R_format==1)?aluc:ALUop;

//ALUcontrol
ALUctl alu_ctl(instruction[5:0],R_format,aluc[4:0],Sftmd,jr,jalr);

assign shamt=(Sftmd==1)?instruction[10:6]:5'b00000;
//ALU
ALU alu(rdata1,aludata2,ALUctr[4:0],ALUresult,shamt[4:0],zero,carry,overflow);

//regfile
wire [4:0]reg31=5'b11111;
MUX_3src_5bit wreg_mux(instruction[20:16],instruction[15:11],reg31[4:0],RegDST,jal,wreg);
regfile rf(clk,rst,RegWrite,instruction[25:21],
instruction[20:16],wreg,busW[31:0],rdata1,rdata2);

MUX jalr_mux(wdata,pc_plus4,(jalr||jal),busW);//jalr mux for writing Rd

//dm
MUX alusrc_mux(rdata2,ext_result,ALUSrc,aludata2);
dm_4k dm(sb,lb,lbu,ALUresult[11:0],rdata2,MemWrite,clk,rdata);
MUX regsrc_mux(ALUresult,rdata,MemtoReg,wdata[31:0]);

endmodule