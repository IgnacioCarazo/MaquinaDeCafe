`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Name: Pablo Mendoza Ponce
// Create Date: 15.05.2021
// Module Name: Controlador
// Project Name: Maquina microprogramada
//////////////////////////////////////////////////////////////////////////////////

//controlador microprogramado
module Controlador(
    input clk,
    input rst,
    input Condicion1,
    input Condicion2,
    input Condicion3,
    input Condicion4,
    input Condicion5,
    input Condicion6,
    output salida0,
    output salida1,
    output salida2,
    output salida3,
    output salida4,
    output salida5,
    output salida6,
    output salida7
    );
    
    parameter ANCHO_CONTADOR = 8;//Ancho del contador y del bus de la memoria
    parameter BITS_SELECCION_SALTO = 3;//bits usados para seleccionar condiciones de salto
    parameter ANCHO_MEMORIA = ANCHO_CONTADOR+8+1+BITS_SELECCION_SALTO; //20 bits en este ejemplo
    
    
    wire [ANCHO_CONTADOR-1:0] Cuenta_Direccion_Memoria;
    wire [ANCHO_CONTADOR-1:0] Direccion_Salto;
    wire [BITS_SELECCION_SALTO-1:0] Seleccion_De_Condicion_Salto;
    wire Senal_De_Carga_Contador;
    
    wire tmp0;//para relleno, no se usa en este ejemplo
    
    CounterWithLoad #(.ANCHO(ANCHO_CONTADOR)) Uconta (
        .clk(clk),
        .rst(rst),
        .LD_C(Senal_De_Carga_Contador), //cargar (1), contar (0)
        .CuentaEntrada(Direccion_Salto), //Valor para carga paralela (donde vamos a saltar)
        .cuenta(Cuenta_Direccion_Memoria) //salida del contador
    );
    
    SimpleRom  #(.ANCHO(ANCHO_MEMORIA), .ANCHO_DIR(ANCHO_CONTADOR)) Umem (
        .A(Cuenta_Direccion_Memoria), //direcci�n 
        .Do({
            Direccion_Salto, //8 bits //bits 19-12
            salida7, //8 bits de salida  //bit 11
            salida6, //bit 10
            salida5, //bit 9
            salida4, //bit 8
            salida3, //bit 7
            salida2, //bit 6
            salida1, //bit 5
            salida0, //bit 4
            tmp0,// 1 bit de relleno  //bit 3
            Seleccion_De_Condicion_Salto //3 bits de selecci�n de salto  //bits 2-0 
        }) //Dato de salida de memoria -- TOTAL: 20 bits (5 digitos en hex)
    );
    
    MuxCondiciones #(.SEL_BITS(BITS_SELECCION_SALTO)) MUX(
       .sel(Seleccion_De_Condicion_Salto), //Bus de selecci�n 
       /*
       Para el ejemplo de 3 bits de selecci�n de salto:
       La selecci�n en 000 significa NO SALTO
       La selecci�n en 111 significa SALTO INCONDICIONAL
       Cualquier otra selecci�n corresponde a las condiciones...
       
       **RECORDAR que el contador salta si la condici�n es 1
         y continua contando si la condici�n es 0!!!
       */
       .in_bits(//8 opciones
            {1'b1,//salto incondicional
            Condicion6, //sel 6
            Condicion5, //sel 5
            Condicion4, //sel 4
            Condicion3, //sel 3
            Condicion2, //sel 2
            Condicion1, //sel 1
            1'b0}//NO saltar //menos significativo
            ), //los bits de entrada: 2^SEL_BITS (ej.: 2^3=8 bits)
       .out(Senal_De_Carga_Contador) //bit de salida
    );
    
endmodule
