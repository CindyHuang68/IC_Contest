module multiplier(X,Y,Z);

input signed [10:0]X,Y;
output signed [21:0]Z;

assign Z=X*Y;

endmodule