`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Name: Ignacio Carazo Nieto
// Create Date: 10.06.2021
// Module Name: caso_uno
// Project Name: Maquina microprogramada
//////////////////////////////////////////////////////////////////////////////////

module caso_uno;
    
    reg clk,rst;

    wire S0,S1,S2,S3,S4,S5,S6,S7;
    reg hm,ha,bp,bb,hc,tm;

    initial begin
        $dumpfile("caso_uno.vcd");
        $dumpvars(0,caso_uno);
    end

    always #50 clk=~clk;

    initial begin
        clk=0;
		//aplicar reset
        rst=0;
        repeat (2) begin
            @(posedge clk);
        end
        rst=1;
		//reset aplicado
    end

	initial begin
		hm=1; ha=1; bp=1; bb=1; hc=1; tm=1;
		
      repeat (2) begin
            @(posedge clk);
        end
      	hm = 0;
      	
     	
      repeat (2) begin
            @(posedge clk);
        end
      	bp = 0;
      	hm = 1;
      repeat (1) begin
            @(posedge clk);
        end
      	
      	tm = 0;
      
      repeat (5) begin
            @(posedge clk);
        end
      
      
      	
     	
      	
		$finish;
	end
    
	initial begin //en caso de que no se cumplan las condiciones de arriba
    	repeat (200) begin
			@(posedge clk);
		end
		$finish;
	end

    
    Controlador DUT (
        .clk(clk),
        .rst(rst),
      .Condicion1(hm),
      .Condicion2(ha),
      .Condicion3(bp),
      .Condicion4(bb),
      .Condicion5(hc),
      .Condicion6(tm),
        .salida0(S0),
        .salida1(S1),
        .salida2(S2),
        .salida3(S3),
        .salida4(S4),
        .salida5(S5),
        .salida6(S6),
        .salida7(S7)
    );

endmodule