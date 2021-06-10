//////////////////////////////////////////////////////////////////////////////////
// Name: Pablo Mendoza Ponce
// Create Date: 13.05.2021
// Module Name: SimpleRom
// Project Name: Maquina microprogramada
//////////////////////////////////////////////////////////////////////////////////

// MODELO DE COMPORTAMIENTO - NO SINTETIZABLE!!!

`timescale 1ns/1ps
module SimpleRom  #(parameter ANCHO = 20, parameter ANCHO_DIR = 8) (
    //ANCHO: es el tama�o de las palabras almacenadas
    //ANCHO_DIR: El ancho del bus de direcciones!
    //por defecto:
    //Bus de direcciones de 8 bits, lo que genera una memoria con un Largo de 256 palabras
    //El bus de datos es de 20 bits 
    input [ANCHO_DIR-1:0]A, //direcci�n 
    output [ANCHO-1:0]Do //Dato de salida
    );
    reg [ANCHO-1:0] MATRIX [0:(2**ANCHO_DIR)-1];
    
    initial begin
        $readmemh("rom_content_t.mem", MATRIX); //cargar contenido de archivo de memoria (binario)
    end    
    
    assign #5 Do = MATRIX[A]; //simulando 25ns de retraso (un poco m�s real)
    
endmodule

