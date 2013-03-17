//Este módulo conecta los módulos uc y microc.

`include "uc.v"
`include "microc.v"

module procesador(input wire clk, reset,
				  input wire [31:0] in,
				  output wire [31:0] out);

wire z, s_inc, s_inc2, s_inm,s_inm2, we3, enable, fin, clk_;
wire [1:0] s_IO;
wire [2:0] op;
wire [5:0] opcode;

 
assign clk_=fin ?1'b0:clk;
   uc uc_ (clk_, reset, z, opcode, s_inc, s_inc2, s_inm, s_inm2, we3, fin, enable, op, s_IO);
   microc microc_(clk_, reset, s_inc, s_inc2, s_inm, s_inm2, we3, enable, s_IO, op, in, z, opcode, out);
	
	
endmodule
