module control(outside, clk, reset, valid, load, bdctrl, p1, p2, is_inside);
input outside,clk,reset;
output reg valid, load, bdctrl, is_inside;
output reg[2:0]p1, p2;
reg [4:0]cs;
reg [4:0]ns;
reg valid_d, is_inside_d;

//seq
always@(posedge clk or posedge reset)begin
	if (reset)
		cs <= 5'd0;
	else
		cs <= ns;
end


//combinational
//assign ns = cs + 1'd1;

always@(*)
	if(cs<=5'd17)
		ns = cs + 1'd1;
	else
	case(cs)
		5'd18:ns=(outside)?5'd24:5'd19;
		5'd19:ns=(outside)?5'd24:5'd20;
		5'd20:ns=(outside)?5'd24:5'd21;
		5'd21:ns=(outside)?5'd24:5'd22;
		5'd22:ns=(outside)?5'd24:5'd23;
		5'd23:ns=(outside)?5'd24:5'd25;
		5'd24:ns=5'd26;
		5'd25:ns=5'd26;
		default:ns=5'd0;
	endcase	
//valid
always@(*)
	case(cs)
	5'd0: begin 
			 valid_d = 1'd0;
			 is_inside_d =1'd0;
		  end
	5'd24: begin
		   valid_d = 1'd1;
	       is_inside_d =1'd0;
		   end
	5'd25: begin
		   valid_d = 1'd1;
	       is_inside_d =1'd1;
		   end
/*	5'd26: begin
		   valid_d = 1'd1;
	       is_inside_d =1'd0;
		   end
	5'd27: begin
		   valid_d = 1'd1;
	       is_inside_d =1'd1;
		   end	   */
	default: begin 
			 valid_d = 1'd0;
			 is_inside_d =1'd0;
			 end
	endcase
	
	
always@(posedge clk or posedge reset)begin
	if (reset)
		valid <= 5'd0;
	else
		valid <= valid_d;
end


always@(posedge clk or posedge reset)begin
	if (reset)
		is_inside <= 5'd0;
	else
		is_inside <= is_inside_d;
end



//load
always@(*)
	case(cs)
	5'd0:load = 1'd1;
	5'd1:load = 1'd1;
	5'd2:load = 1'd1;
	5'd3:load = 1'd1;
	5'd4:load = 1'd1;
	5'd5:load = 1'd1;
	5'd6:load = 1'd1;
	default: load = 1'd0;
	endcase
// bdctrl
always@(*)
	case(cs)
	5'd7:bdctrl = 1'd1;
	5'd8:bdctrl = 1'd1;
	5'd9:bdctrl = 1'd1;
	5'd10:bdctrl = 1'd1;
	5'd11:bdctrl = 1'd1;
	5'd12:bdctrl = 1'd1;
	5'd13:bdctrl = 1'd1;
	5'd14:bdctrl = 1'd1;
	5'd15:bdctrl = 1'd1;
	5'd16:bdctrl = 1'd1;
	5'd17:bdctrl = 1'd1;
	default: bdctrl = 1'd0;
	endcase
//p1,p2
always@(*)
	case(cs)
	5'd7:begin//4
		p1 = 3'd2;
		p2 = 3'd3;
		end
	5'd8: begin
		p1 = 3'd3;
		p2 = 3'd4;
		end
	5'd9: begin
		p1 = 3'd4;
		p2 = 3'd5;
		end
	5'd10: begin
		p1 = 3'd5;
		p2 = 3'd6;
		end
	5'd11:begin//3
		p1 = 3'd2;
		p2 = 3'd3;
		end
	5'd12: begin
		p1 = 3'd3;
		p2 = 3'd4;
		end
	5'd13: begin
		p1 = 3'd4;
		p2 = 3'd5;
		end
	5'd14:begin//2
		p1 = 3'd2;
		p2 = 3'd3;
		end
	5'd15: begin
		p1 = 3'd3;
		p2 = 3'd4;
		end
	5'd16:begin//2
		p1 = 3'd2;
		p2 = 3'd3;
		end
	5'd17:begin
		p1 = 3'd3;
		p2 = 3'd4;
		end
	5'd18:begin//decide
		p1 = 3'd1;
		p2 = 3'd2;
		end
	5'd19:begin
		p1 = 3'd2;
		p2 = 3'd3;
		end
	5'd20:begin
		p1 = 3'd3;
		p2 = 3'd4;
		end
	5'd21:begin
		p1 = 3'd4;
		p2 = 3'd5;
		end
	5'd22:begin
		p1 = 3'd5;
		p2 = 3'd6;
		end
	5'd23:begin
		p1 = 3'd6;
		p2 = 3'd1;
		end
	default: begin
		p1 = 3'd2;
		p2 = 3'd3;
		end
	endcase
endmodule