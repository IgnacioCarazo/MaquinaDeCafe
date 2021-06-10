`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Name: Pablo Mendoza Ponce
// Create Date: 13.05.2021
// Module Name: CounterWithLoad
// Project Name: Maquina microprogramada
//////////////////////////////////////////////////////////////////////////////////

//contador con carga!
module CounterWithLoad #(parameter ANCHO = 8) (
    input clk,
    input rst,
    input LD_C, //cargar (1), contar (0)
    input [ANCHO-1:0] CuentaEntrada, //Valor para carga paralela (donde vamos a saltar)
    output reg [ANCHO-1:0] cuenta  //salida del contador
    );
    
    always @(posedge clk)
      if (!rst) //reset activo en BAJO
         cuenta <= {ANCHO{1'b0}};
      else
         if (LD_C) //si LD_C es 1 entonces cargue el valor a la entrada
            cuenta <= CuentaEntrada;
         else // sino entonces cuente hacia arriba
            cuenta <= cuenta + 1'b1;
    
endmodule