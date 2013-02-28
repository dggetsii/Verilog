`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulaci�n y el paso de simulaci�n

module cuenta1_cableada_tb;


reg [2:0] t_valor;
reg t_start, t_clk;
wire [3:0] t_cuenta;
wire t_fin; 

//instancia del modulo a testear


cuenta1_cableada cachibache(t_valor, t_start, t_clk, t_cuenta, t_fin);	//Instancia modulos uc cableada.




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
  $monitor("tiempo=%0d Valor=%b start=%b clk=%b Cuenta=%b fin=%b", $time, t_valor, t_start, t_clk, t_cuenta, t_fin);
  $dumpfile("cachibache.vcd");
  $dumpvars;

   t_start = 1;
   #5;
   t_start = 0;
   #3;

   t_valor = 3'b111;
   #500;

  $finish;  //fin simulacion

end
endmodule
