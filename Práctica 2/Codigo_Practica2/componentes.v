//Componentes varios

//Banco de registros de dos salidas y una entrada
module regfile(input wire clk,
               input wire we3, //señal de habilitación de escritura
               input wire [3:0] ra1, ra2, ra3, wa3, //valores de regs leidos y reg a escribir
               input wire [7:0] wd3, //dato a escribir
               output wire [7:0] rd1, rd2, rd3, output wire [7:0] test); //salida de datos leidos

   reg [7:0] regb[0:15]; //memoria de 16 registros de 8 bits de ancho
  
   //assign regb[0] = 0;
  
   // El registro 0 siempre es cero
   // se leen dos reg combinacionalmente
   // y la escritura del tercero ocurre en flanco de subida del reloj
   always @(posedge clk)
	if (we3) regb[wa3] <= wd3;
	
   assign test = regb[4'b0001];
   assign rd1 = (ra1 != 0) ? regb[ra1] : 0;
   assign rd2 = (ra2 != 0) ? regb[ra2] : 0;
   assign rd3 = (ra3 != 0) ? regb[ra3] : 0;
   

endmodule

//modulo sumador
module sum(input wire [9:0] a, b,
             output wire [9:0] y);

   assign y = a + b;
endmodule

//modulo de registro para modelar el PC, cambia en cada flanco de subida de reloj o de reset
module registro #(parameter WIDTH = 8)
              (input wire clk, reset,
               input wire [WIDTH-1:0] d,
               output reg [WIDTH-1:0] q);

   always @(posedge clk, posedge reset)
      if (reset) q <= 0;
      else q <= d;
endmodule

//modulo multiplexor, cos s=1 sale d1, s=0 sale d0
module mux2 #(parameter WIDTH = 8)
             (input wire [WIDTH-1:0] d0, d1,
              input wire s,
              output wire [WIDTH-1:0] y);

   assign y = s ? d1 : d0;
endmodule


module flop (input wire clk, d, output reg q);
   always @(posedge clk)
      if(d) q <= d;
      else q <= 0;
endmodule


module mux4 #(parameter WIDTH = 8)
		(input wire [WIDTH-1:0] d0, d1,d2,d3,
		input wire [1:0] s,
		output reg [WIDTH-1:0] y);
	always @(*)
		  case( s )
		    2'b00: y=d0;
		    2'b01: y=d1;
		    2'b10: y=d2;
		    2'b11: y=d3;
		   endcase
      
endmodule

module decoder (input wire [1:0] s, input wire enable, output reg  [3:0] sdec);
	always @(*)
	begin
		sdec[3:0]=4'b0000;
		if (enable)
		begin
			case( s )
			2'b00:
			sdec[0]=1;
			2'b01: 
			sdec[1]=1;
			2'b10: 
			sdec[2]=1;
			2'b11: 
			sdec[3]=1;
			endcase
		end
	end
endmodule

module ffdc (input wire clk, reset, enable, input wire [7:0] rd3, output reg [7:0] q);
//reset asíncrono, carga síncrona
always @(posedge clk, posedge reset)
begin
	if (reset)
		q <=  1'b0; //asignación no bloqueante q=0
	else
	begin
		if (enable)
			q <= rd3; //asignación no bloqueante q=d	
	end		
end
endmodule

		  
  
  