`include "gt.v"

module uc_cableada(input wire q0, start, clk, output wire CargaQ, DesplazaQ, ResetA, CargaA, Fin);

wire [7:0] out_t;

generador gt(clk, start, out_t);

assign CargaQ = out_t[0];
assign DesplazaQ = (out_t[2] | out_t[4]);
assign ResetA = out_t[0];
assign CargaA = (q0 & (out_t[1] | out_t[3] | out_t[5]));
assign Fin = out_t[6];

endmodule
