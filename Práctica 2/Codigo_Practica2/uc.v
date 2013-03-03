module uc (input wire clk, reset, z, input wire [5:0] opcode, output reg s_inc, s_inm, we3,fin , output reg [2:0] op);//Cambiams wire por reg



always @( * )
	casex (opcode)

		6'bxx0xxx://ALU
			begin
				we3 <= 1'b1;//Activar escritura				
				op=opcode[2:0];
				s_inc <= 1'b1; //Incrementa PC
				s_inm <= 1'b0; //Salida sumador a banco de registro				
			end

		6'bxx1000://CARGA
			begin
				s_inc <= 1'b1; //Suma uno a PC
				s_inm <= 1'b1; //WA3 a banco de registro y Dato inmediato a WD3
				we3 <=1'b1; //Habilitar escritura
			end

		6'bxx1001://SALTO ABSOLUTO
			begin
				s_inc <= 1'b0; // Direccion a PC
				s_inm <= 1'b0; //No tiene importancia
				we3 <= 1'b0; //No se escribe
			end

		6'bxx1010://SALTO CONDICIONAL 0
			begin
				s_inm <= 1'b0;
				we3 <= 1'b0;			
				if (z)				// 1 -> resultado op anterior 0
					s_inc <= 1'b0; //Salto a la instruccion en registro de direccion
				else
					s_inc <= 1'b1; //Salto a la siguiente instruccion
			end

		6'bxx1011://SALTO CONDICIONAL no 0
			begin
				s_inm <= 1'b0;
				we3 <= 1'b0;
				if (z)			
					s_inc <= 1'b1; //Siguiente instruccion
				else
					s_inc <= 1'b0; //Salto a la siguiente
			end
/*
		6'bxx1100://SALTO RELATIVO
			begin
				we3 <=1'b0					
				op=opcode[2:0];
				s_inc <=
				s_inm <=				
			end
*/		6'bxx1111://Halt
			fin <= 1'b1;							
			
	endcase

endmodule

