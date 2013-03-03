`include "componentes.v"
`include "alu.v"
`include "memprog.v"

module microc(input wire clk, reset, s_inc, s_inm, we3, input wire [2:0] op, output wire z, output wire [5:0] opcode);
//Microcontrolador sin memoria de datos de un solo ciclo

wire [9:0] ePC;
wire [9:0] ssum;//salida del sumador
wire [9:0] sPC;//salida PC
wire [15:0] smem;//salida memoria
wire [7:0] srd1;
wire [7:0] srd2;
wire [7:0] salu;
wire [7:0] wd3;
wire z_salu;
//Instanciar e interconectar pc, memprog, regfile, alu, sum y mux's



registro #10 PC(clk,reset,ePC,sPC);
memprog mem_(clk,sPC,smem);
regfile banco(clk,we3,smem[7:4],smem[11:8],smem[15:12],wd3,srd1,srd2);
alu alu_ (srd1,srd2,op,salu,z_salu);
flop ffp1(clk,z_salu,z);

sum sumador(sPC,1'b1,ssum);

mux2 #(10) mux2_1(smem[15:6],ssum,s_inc,ePC);//Sumador del PC 
mux2 #(8) mux2_2(salu,smem[11:4],s_inm,wd3);//Entrada banco registros


assign opcode = smem[5:0];




endmodule
