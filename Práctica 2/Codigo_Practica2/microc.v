//ESTE MÓDULO CONECTA LOS COMPONENTES, LA ALU Y LA MEMORIA.

`include "componentes.v"
`include "alu.v"
`include "memprog.v"

module microc(input wire clk, reset, s_inc, s_inc2, s_inm,s_inm2, we3, enable,
			  input wire [1:0] s_IO, input wire [2:0] op, output wire z, 
			  output wire [5:0] opcode, output wire [7:0] pro_out1,pro_out2,pro_out3,pro_out4,
			  input wire [7:0] v_i1,v_i2,v_i3,v_i4, output wire [7:0] test);

//Microcontrolador sin memoria de datos de un solo ciclo

   wire [9:0] sm3;
   wire [9:0] ePC;
   wire [9:0] ssum;//salida del sumador
   wire [9:0] sPC;//salida PC
   wire [15:0] smem;//salida memoria
   wire [7:0] srd1;
   wire [7:0] srd2;
   wire [7:0] srd3; //Salida BANCO-OUTPUT
   wire [7:0] salu;
   wire [7:0] wd3;
   wire z_salu;

   wire [7:0] smInput; //Salida multiplexor entrada
   wire[7:0]sm4 ; //Salida multiplexor m4
    wire[3:0]sdec; //Salida DECODER
   
   
   //Cables puertos IO
   wire [7:0] sri [3:0];
   wire [7:0] ero [3:0];
   
   
//Instanciar e interconectar pc, memprog, regfile, alu, sum y mux's

   registro #10 PC(clk,reset,ePC,sPC);
   memprog mem_(clk,sPC,smem);
   regfile banco(clk,we3,smem[7:4],smem[11:8], smem[15:12], smem[15:12],wd3,srd1,srd2, srd3, test);
   alu alu_ (srd1,srd2,op,salu,z_salu);
   flop ffp(clk,z_salu,z);

   sum sumador(sPC,sm3,ssum);

   mux2 #(10) mux2_1(smem[15:6],ssum,s_inc,ePC);//Sumador del PC
   mux2 #(8) mux2_2(salu,sm4,s_inm,wd3);//Entrada banco registros

   mux2 #(10) mux2_3(10'b0000000001, smem[15:6], s_inc2, sm3);//Salto relativo
   
   
   mux2 #(8) mux_2_4(smem[11:4],smInput,s_inm2,sm4);//Entrada o carga
   mux4 #(8) mux_I(sri[0],sri[1],sri[2],sri[3],s_IO,smInput); //Seleccion de puerto entrada
   decoder dec_O(s_IO, enable, sdec);  //Seleccion puerto salida //!!!!!!!!!!!!!!!!!!!!!!!!!!
   
  
   //Registros entrada
   //clk, reset, entrada, salida
   registro #8 r_i1(clk,reset,v_i1,sri[0]);
   registro #8 r_i2(clk,reset,v_i2,sri[1]);
   registro #8 r_i3(clk,reset,v_i3,sri[2]);
   registro #8 r_i4(clk,reset,v_i4,sri[3]);
   
   //Registros salida
   //clk, reset, enable, entrada, salida
   ffdc r_o1(clk, reset, sdec[0], srd3,pro_out1);
   ffdc r_o2(clk, reset, sdec[1], srd3,pro_out2);
   ffdc r_o3(clk, reset, sdec[2], srd3,pro_out3);
   ffdc r_o4(clk, reset, sdec[3], srd3,pro_out4);
   
   

   assign opcode = smem[5:0];

endmodule
