module uc (input wire clk, reset, z, input wire [5:0] opcode,
		    output reg s_inc, s_inc2, s_inm,s_inm2, we3,fin, enable,
		    output reg [2:0] op, output reg [1:0] s_IO);

always @(*)

begin
	casex (opcode)

   	6'bxx0xxx://ALU
   	begin
	   	we3 <= 1'b1;//Activar escritura
	   	op=opcode[2:0];
	   	s_inc <= 1'b1; //Incrementa PC
		s_inc2 <= 1'b0;
	   	s_inm <= 1'b0; //Salida sumador a banco de registro
		s_inm2 <= 1'b0;
		enable <= 1'b0;
		  fin <= 1'b0;
   	end

	   6'bxx1000://CARGA
   	begin
   		s_inc <= 1'b1; //Suma uno a PC
		s_inc2 <= 1'b0;
   		s_inm <= 1'b1; //WA3 a banco de registro y Dato inmediato a WD3
   		we3 <=1'b1; //Habilitar escritura
		s_inm2 <= 1'b0;
		enable <= 1'b0;
		fin <= 1'b0;
   	end

   	6'b001001://SALTO ABSOLUTO
   	begin
   		s_inc <= 1'b0; // Direccion a PC
		s_inc2 <= 1'b0;
   		we3 <= 1'b0; //No se escribe
   		enable <= 1'b0;
   		fin <= 1'b0;
   	end

   	6'b011001://SALTO CONDICIONAL 0
   	begin
   		we3 <= 1'b0;
		s_inc2 <= 1'b0;
   		if (z) // 1 -> resultado op anterior 0
   			s_inc <= 1'b0; //Salto a la instruccion en registro de direccion
   		else
   			s_inc <= 1'b1; //Salto a la siguiente instruccion
   		enable <= 1'b0;
   		fin <= 1'b0;
   	end

   	6'b101001://SALTO CONDICIONAL no 0
   	begin
   		we3 <= 1'b0;
		s_inc2 <= 1'b0;
		enable <= 1'b0;
   		if (z)
   			s_inc <= 1'b1; //Siguiente instruccion
   		else
	   		s_inc <= 1'b0; //Salto a la siguiente
	   	fin <= 1'b0;
   	end
   	6'b111001://SALTO RELATIVO
   	begin
   		we3 <=1'b0;
   		s_inc <= 1'b1;
		s_inc2 <= 1'b1;
		enable <= 1'b0;
		fin <= 1'b0;
   	end
   	
	   6'b111111://Halt
	      fin <= 1'b1;

	   6'bxx1010://Entrada
	   begin
		we3 <=1'b1;
   		s_inc <= 1'b1;
		s_inc2 <= 1'b0;
   		s_inm <= 1'b1;
   		s_inm2 <= 1'b1;
   		enable <= 1'b0;
   		fin <= 1'b0;
   		s_IO <= opcode[5:4];
	   end
	   6'bxx1011://Salida
	    begin
	    	we3 <=1'b0;
   		s_inc <= 1'b1;
		s_inc2 <= 1'b0;//coge 1
		enable <= 1'b1;
   		s_IO <= opcode[5:4];
   		fin <= 1'b0;
	    end
   endcase
end
endmodule
