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
reg [7:0]  t_v1,t_v2,t_v3,t_v4;
wire [7:0]  t_out1,t_out2,t_out3,t_out4,  t_test;

initial
begin
t_v1=8'b00000101 ;
t_v2=8'b00000001;
t_v3=8'b00000100;
t_v4=0;
end

procesador intel(t_clk,t_reset,t_v1, t_v2, t_v3, t_v4, t_out1,t_out2,t_out3,t_out4, t_test);

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
