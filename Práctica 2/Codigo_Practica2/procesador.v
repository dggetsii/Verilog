//Este módulo conecta los módulos uc y microc.

`include "uc.v"
`include "microc.v"

module procesador(input wire clk, reset,
				  input wire [7:0] v_i1,v_i2,v_i3,v_i4,
				  output wire [7:0] pro_out1,pro_out2,pro_out3,pro_out4,
				  output wire [7:0] test); //VALOR BANCO REGISTRO (15:0)

wire z, s_inc, s_inc2, s_inm,s_inm2, we3, enable, fin;
wire [1:0] s_IO;
wire [2:0] op;
wire [5:0] opcode;

   uc uc_ (clk, reset, z,opcode, s_inc, s_inc2, s_inm,s_inm2, we3,fin,enable, op ,s_IO);
   microc microc_(clk, reset, s_inc, s_inc2, s_inm, s_inm2, we3, enable, s_IO, op, z, opcode,pro_out1,pro_out2,pro_out3,pro_out4, v_i1,v_i2,v_i3,v_i4, test);

endmodule
