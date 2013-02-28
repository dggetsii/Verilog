module decodificador(input wire [2:0] tiempo, output wire [7:0] t);
assign t=1<<tiempo;
endmodule