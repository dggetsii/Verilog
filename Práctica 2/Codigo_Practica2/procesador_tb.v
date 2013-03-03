`timescale 1 ns / 10 ps
`include "procesador.v"

module procesador_tb;
reg t_clk, t_reset;
wire t_s_inc, t_s_inm,t_we3, t_fin, t_z;
wire [2:0] t_op;
wire [5:0] t_opcode;


procesador intel(t_clk,t_reset,t_z,t_s_inc,t_s_inm,t_we3,t_fin,t_op,t_opcode);
always //siempre activo, no hay condición de activación
begin	
	
		if(t_fin)
		begin
			t_clk = 0;
			#5;
		end
		else
		begin			
		t_clk = 1;
		#5;
		t_clk = 0;
		#5;
		end
			
end

initial
begin
  $monitor();
  $dumpfile("intel.vcd");
  $dumpvars;	
	t_reset = 1'b1;
	#5;
	t_reset = 1'b0;

	#800;
  $finish;
end
endmodule
