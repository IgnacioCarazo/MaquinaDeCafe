`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Pablo Mendoza Ponce
// Create Date: 13.05.2021
// Module Name: MuxCondiciones
// Project Name: Maquina microprogramada
//////////////////////////////////////////////////////////////////////////////////


module MuxCondiciones #(parameter SEL_BITS=3)(
    input [SEL_BITS-1:0] sel, //Bus de selecci�n con ancho SEL_BITS (ej.: 3 bits)
    input [(2**SEL_BITS)-1:0] in_bits, //los bits de entrada: 2^SEL_BITS (ej.: 2^3=8 bits)
    output reg out //bit de salida
    );
    
    always @(*)
        out = in_bits[sel];
        
endmodule
