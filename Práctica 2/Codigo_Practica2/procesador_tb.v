`timescale 1 ns / 10 ps
`include "procesador.v"
/*
decoder
modificar s_I,s_O=>s_IO
crear nuevo registros con enable
crear programa op, por ejemplo lol
*/
module procesador_tb;

reg t_clk, t_reset;
wire [31:0] t_out;
reg [31:0] t_in;

initial
begin
assign t_in[7:0]=8'b00000101 ;
assign t_in[15:8]=8'b00000001;
assign t_in[23:16]=8'b00000100;
assign t_in[31:24]=0;
end

procesador intel(t_clk,t_reset,t_in,t_out);

always //siempre activo, no hay condición de activación
begin
      t_clk = 1;
      #5;
      t_clk = 0;
      #5;
end

initial
begin
   $monitor();
   $dumpfile("intel.vcd");
   $dumpvars;
   t_reset = 1'b1;
   #2;
   t_reset = 1'b0;

   #800;
   $finish;
end
endmodule
