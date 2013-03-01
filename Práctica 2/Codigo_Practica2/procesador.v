`include "uc.v"
`include "microc.v"

module procesador(input wire clk, reset,output wire z, s_inc, s_inm, we3,fin,output wire [2:0] op,output wire [5:0] opcode);

uc uc_ (clk, reset, z,opcode, s_inc, s_inm, we3,fin , op);
microc microc_(clk, reset, s_inc, s_inm, we3, op, z, opcode);

endmodule
