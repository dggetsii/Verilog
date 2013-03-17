//ESTE MÓDULO CONECTA LOS COMPONENTES, LA ALU Y LA MEMORIA.
//Microcontrolador sin memoria de datos de un solo ciclo

`include "componentes.v"
`include "alu.v"
`include "memprog.v"

module microc(input wire clk, reset, s_inc, s_inc2, s_inm,s_inm2, we3, enable,
			  input wire [1:0] s_IO, input wire [2:0] op,input wire [31:0] in, output wire z, 
			  output wire [5:0] opcode, output wire [31:0] out);

//Declaracion de wires para la conexion de modulos.

   wire [9:0] sm3, ePC, ssum, sPC;
   //salida memoria   
   wire [15:0] smem;
   wire [7:0] srd1,srd2,srd3,salu,wd3,smInput,sm4;
   wire z_salu;
   //Salida DECODER
   wire[3:0]sdec; 
   //Cables puertos IO
   wire [7:0] sri [3:0];
   wire [7:0] ero [3:0];
   
//----------------------------------------------------------------------------------------------------//
//Instancia del PC
   registro #10 PC(clk,reset,ePC,sPC);

//Instancia de la memoria del programa
   memprog mem_(clk,sPC,smem);

//Instancia del banco de registros
   regfile banco(clk,we3,smem[7:4],smem[11:8], smem[15:12], smem[15:12],wd3,srd1,srd2,srd3);

//Instanciacion de la ALU
   alu alu_ (srd1,srd2,op,salu,z_salu);

//Instanciacion flip-flop
   flop ffp(clk,z_salu,z);

//Instanciacion sumador de instruccion
   sum sumador(sPC,sm3,ssum);

//Instanciacion multiplexor sumador PC
   mux2 #(10) mux2_1(smem[15:6],ssum,s_inc,ePC);

//Instanciacion multiplexor entrada banco registros
   mux2 #(8) mux2_2(salu,sm4,s_inm,wd3);

//Instanciacion multiplexor salto relativo
   mux2 #(10) mux2_3(10'b0000000001, smem[15:6], s_inc2, sm3);
   
//Instanciacion multiplexor ??????????????   
   mux2 #(8) mux_2_4(smem[11:4],smInput,s_inm2,sm4);

//Instanciacion multiplexor puertos de entrada
   mux4 #(8) mux_I(sri[0],sri[1],sri[2],sri[3],s_IO,smInput); //Seleccion de puerto entrada
   
//Instanciacion decodificador de enables.
   decoder dec_O(s_IO, enable, sdec); 
   
  // 0:7 8:15 16:23 24:31
   //Registros entrada
   //clk, reset, entrada, salida
   registro #8 r_i1(clk,reset,in[7:0],sri[0]);
   registro #8 r_i2(clk,reset,in[15:8],sri[1]);
   registro #8 r_i3(clk,reset,in[23:16],sri[2]);
   registro #8 r_i4(clk,reset,in[31:24],sri[3]);
   
   //Registros salida
   //clk, reset, enable, entrada, salida
   ffdc r_o1(clk, reset, sdec[0], srd3,out[7:0]);
   ffdc r_o2(clk, reset, sdec[1], srd3,out[15:8]);
   ffdc r_o3(clk, reset, sdec[2], srd3,out[23:16]);
   ffdc r_o4(clk, reset, sdec[3], srd3,out[31:24]);
   
  
   assign opcode = smem[5:0];

endmodule
