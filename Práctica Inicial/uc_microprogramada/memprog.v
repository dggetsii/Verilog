//Memoria de programa

module memprog(input  wire clk,
               input  wire [:0] direccion,
               output wire [:0] datos);

  reg [:0] mem[0:]; //memoria de 1024 palabras de 16 bits de ancho

  initial
  begin
    $readmemb("progfile.dat",mem); // inicializa la memoria del fichero en texto binario
  end
  assign rd = mem[a]; 
endmodule


