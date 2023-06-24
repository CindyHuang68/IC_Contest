`include "operator.v"
`include "control.v"

module geofence ( clk,reset,X,Y,valid,is_inside);
input			clk;
input			reset;
input	[9:0]	X;
input	[9:0]	Y;
output			valid;
output			is_inside;

wire [2:0]p1,p2;
wire load, bdctrl, outside;
operator opu0(.outside(outside),.X(X), .Y(Y), .clk(clk), .reset(reset), .load(load), .bdctrl(bdctrl), .p1(p1), .p2(p2));
control controlu0(.outside(outside),.clk(clk), .reset(reset), .valid(valid), .load(load), .bdctrl(bdctrl), .p1(p1), .p2(p2), .is_inside(is_inside));



endmodule

