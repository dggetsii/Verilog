`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulaci�n y el paso de simulaci�n

`include "uc_estados.v"
`include "uc_cableada.v"
`include "regA.v"
`include "regQ.v"
`include "sum4.v"
`include "ffdc.v"


module cuenta1_tb;


reg [2:0] t_valor;
reg t_start, t_clk;
wire [3:0] t0_cuenta, t1_cuenta;
wire t0_fin, t1_fin; 

//instancia del modulo a testear

cuenta1_estados cachibache0(t_valor, t_start, t_clk, t0_cuenta, t0_fin);						//Instancia modulos uc estados.	
cuenta1_cableada cachibache1(t_valor, t_start, t_clk, t1_cuenta, t1_fin);	//Instancia modulos uc cableada.




// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
t_clk = 1;
#20;
t_clk = 0;
#60;
end


initial
begin
  $monitor("tiempo=%0d Valor=%b start=%b clk=%b C0=%b C1=%b f0=%b f1=%b", $time, t_valor, t_start, t_clk, t0_cuenta, t0_fin, t1_cuenta, t1_fin);
  $dumpfile("cachibache.vcd");
  $dumpvars;

   t_start = 1;
   #5;
   t_start = 0;
   #3;

   t_valor = 3'b001;
   #500;

  $finish;  //fin simulacion

end
endmodule
