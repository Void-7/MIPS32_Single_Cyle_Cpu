module dm_4k( sb,loadbyte,loadbyteu,addr, din, we, clk, dout ) ;

input			sb;//1:sb
input   		loadbyte;//1:lb
input			loadbyteu;//1:lbu
input   [11:0]  addr ;  // address bus     
input   [31:0]  din ;   // 32-bit input data     
input           we ;    // memory write enable     
input           clk ;   // clock

output reg[31:0] dout ;  // 32-bit memory output 

reg [31:0] dm [1023:0]; // 1024 * 4 = 4096

reg signed [31:0]o;
reg [31:0]uo;

integer i;
initial begin
		for(i=0;i<1024;i=i+1)begin
			dm[i]=32'b0;end
		uo<=32'b0;
		o<=32'b0;
end

always @ (posedge clk) begin
    if(we&!sb) begin
        dm[addr[11:2]] <= din;
    end 
	if(we&sb) begin
		case(addr[1:0])
		2'b00:begin dm[addr[11:2]][7:0]<=din[7:0];end
		2'b01:begin dm[addr[11:2]][15:8]<=din[7:0];end
		2'b10:begin dm[addr[11:2]][23:16]<=din[7:0];end
		2'b11:begin dm[addr[11:2]][31:24]<=din[7:0];end
		endcase
	end
end

wire[31:0] r;
assign r=dm[addr[11:2]];

always@(*) begin
	if(loadbyte)begin
		case(addr[1:0])
		2'b00:begin o<={{24{r[7]}},r[7:0]};end
		2'b01:begin o<={{24{r[15]}},r[15:8]};end
		2'b10:begin o<={{24{r[23]}},r[23:16]};end
		2'b11:begin o<={{24{r[31]}},r[31:24]};end
		endcase
		dout<=o;
	end
	if(loadbyteu)begin
		case(addr[1:0])
		2'b00:begin uo<={24'b0,r[7:0]};end
		2'b01:begin uo<={24'b0,r[15:8]};end
		2'b10:begin uo<={24'b0,r[23:16]};end
		2'b11:begin uo<={24'b0,r[31:24]};end
		endcase
		dout<=uo;
	end
	if(!loadbyte&&!loadbyteu) dout<=r;
end

endmodule
