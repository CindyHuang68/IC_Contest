`include "multiplierv1.v"
module operator (X, Y, clk, reset, load, bdctrl, p1, p2, outside);
input clk;
input reset;
input load;
input [9:0]	X;
input [9:0]	Y;
input [2:0]p1, p2;
output outside;
input bdctrl;
reg[19:0]addr[6:0];
wire swap,in;

wire [19:0]p1_out, p2_out, thing_or_1,swap1, swap2;
wire [10:0]midX, midY, vectorAX, vectorAY, vectorBX, vectorBY;
wire [21:0]productAXBY, productAYBX, cross_result;

//seq
always@(posedge clk or posedge reset)begin
	if (reset)begin
		addr[6] <= 20'd0;
		addr[5] <= 20'd0;
		addr[4] <= 20'd0;
		addr[3] <= 20'd0;
		addr[2] <= 20'd0;
		addr[1] <= 20'd0;
		addr[0] <= 20'd0;
		end
	else if (load)begin
		addr[6] <= {X, Y};
		addr[5] <= addr[6];
		addr[4] <= addr[5];
		addr[3] <= addr[4];
		addr[2] <= addr[3];
		addr[1] <= addr[2];
		addr[0] <= addr[1];
		end
	else if(swap)begin
		addr[p1] <= swap1;
		addr[p2] <= swap2;
		end
	else begin
		//addr <= addr;
		addr[6] <= addr[6];
		addr[5] <= addr[5];
		addr[4] <= addr[4];
		addr[3] <= addr[3];
		addr[2] <= addr[2];
		addr[1] <= addr[1];
		addr[0] <= addr[0];
	end
end

//comb
mux6to1 mux0(.a(addr[1]),.b(addr[2]),.c(addr[3]),.d(addr[4]),.e(addr[5]),.f(addr[6]),.sel(p1),.out(p1_out));
mux6to1 mux1(.a(addr[1]),.b(addr[2]),.c(addr[3]),.d(addr[4]),.e(addr[5]),.f(addr[6]),.sel(p2),.out(p2_out));

assign thing_or_1 = (bdctrl)?addr[1]:addr[0];
assign midX = (bdctrl) ? {1'b0,thing_or_1[19:10]} : {1'b0,p1_out[19:10]};
assign midY = (bdctrl) ? {1'b0,thing_or_1[9:0]} : {1'b0,p1_out[9:0]};

assign vectorAX = {1'b0,p1_out[19:10]} - {1'b0,thing_or_1[19:10]};
assign vectorAY = {1'b0,p1_out[9:0]} - {1'b0,thing_or_1[9:0]};
assign vectorBX = {1'b0,p2_out[19:10]} - midX;
assign vectorBY = {1'b0,p2_out[9:0]} - midY;

multiplier mul0(.X(vectorAX),.Y(vectorBY),.Z(productAXBY));
multiplier mul1(.X(vectorAY),.Y(vectorBX),.Z(productAYBX));
assign cross_result = productAXBY - productAYBX;//if cross_result[21]==1, <0
assign swap = (bdctrl) ? cross_result[21] : 1'b0;
swap swapu0(.swap(swap), .X(p1_out), .Y(p2_out), .A(swap1), .B(swap2));
assign outside = cross_result[21];

endmodule
//




//swap module
module swap(swap, X, Y, A, B);
input swap;
input [19:0]X,Y;
output [19:0]A,B;
assign A = (swap) ? Y : X;
assign B = (swap) ? X : Y;
endmodule



//mux6to1 module	
module mux6to1(a,b,c,d,e,f,sel,out);
input[19:0]a,b,c,d,e,f;
input[2:0]sel;
output reg[19:0]out;
always@(*)
	case(sel)
	3'd1:out = a;
	3'd2:out = b;
	3'd3:out = c;
	3'd4:out = d;
	3'd5:out = e;
	3'd6:out = f;
	default:out = 20'd0;
	endcase
endmodule

