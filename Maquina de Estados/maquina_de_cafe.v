`timescale 1ns / 1ps

module maquina_de_cafe (
  input clk, rst,
  input hm, ha, bp, bc, bt, hc, md, mc,
  // hay moneda, hay agua, boton pulsado, boton cafe, boton te, hay cafe, moneda diez, moneda cinco
  output reg [2:0] out
);
  reg [3:0] state, next_state;
  
  parameter s_espera_moneda = 4'b0000;
  parameter s_revisar_agua = 4'b0001;
  parameter s_devuelve_moneda = 4'b0010;
  parameter s_espera_boton = 4'b0011;
  parameter s_revisa_boton = 4'b0100;
  parameter s_revisa_cafe = 4'b0101;
  parameter s_revisa_moneda_cafe = 4'b0110;
  parameter s_sirve_cafe = 4'b0111;
  parameter s_revisa_moneda_te = 4'b1000;
  parameter s_sirve_te_devuelve5 = 4'b1001;
  parameter s_sirve_te = 4'b1010;
  
  
  
  //Logica de siguiente estado
  always@(*) begin
    case (state)
      s_espera_moneda: if (hm) next_state = s_revisar_agua;
      				   else next_state = s_espera_moneda;
      
      s_revisar_agua: if (ha) next_state = s_espera_boton;
      				  else next_state = s_devuelve_moneda;
      
      s_devuelve_moneda: next_state = s_espera_moneda;
      
      s_espera_boton: if (bp) next_state = s_revisa_boton;
      				  else next_state = s_espera_boton;
      
      s_revisa_boton: if (bc) next_state = s_revisa_cafe;
      				  else if (bt) next_state = s_revisa_moneda_te;
      
      //proceso si se escoge cafe
      s_revisa_cafe: if (hc) next_state = s_revisa_moneda_cafe;
      				 else next_state = s_devuelve_moneda;
      
      s_revisa_moneda_cafe: if (md) next_state = s_sirve_cafe;
      						else if (mc) next_state = s_devuelve_moneda;
      
      s_sirve_cafe: next_state = s_espera_moneda;
      
      //proceso si se escoge te
      s_revisa_moneda_te: if (md) next_state = s_sirve_te_devuelve5;
      					  else if (mc) next_state = s_sirve_te;
      
      s_sirve_te_devuelve5: next_state = s_espera_moneda;
      
      s_sirve_te:  next_state = s_espera_moneda;
      
      //cantidad de estados es menor a la cantidad de combinaciones de 4 bits
      default: next_state = s_espera_moneda;
      
    endcase
  end
  
  //Memoria
  always @(posedge clk) begin
    if (!rst) state = s_espera_moneda;
    else state = next_state;
  end
  
  //Logica de salida
  always @(*) begin
      case (state) 
        //Outputs:
        //"transicion" = 000
        //devolver moneda = 100
        //servir cafe = 111
        //servir te = 110
        //servir te con vuelto = 101
        
      s_espera_moneda: begin
        			   out = 3'b000;
     				   end
      
      s_revisar_agua: begin
        			  out = 3'b000;
     				  end
      
      s_devuelve_moneda: begin
        				 out = 3'b100;
     				     end
      
      s_espera_boton: begin
        			  out = 3'b000;
     				  end
      
      s_revisa_boton: begin
        			  out = 3'b000;
     				  end
      
      s_revisa_cafe: begin
        			 out = 3'b000;
	   				 end
      
      s_revisa_moneda_cafe: begin
        				    out = 3'b000;
     				  		end
      	
      s_sirve_cafe: begin
        			out = 3'b111;
     				end
      
      s_revisa_moneda_te: begin
        				  out = 3'b000;
     				      end
      
      s_sirve_te_devuelve5: begin
        				    out = 3'b101;
     				        end
      
      s_sirve_te:  begin
        		   out = 3'b110;
     			   end
      endcase
  end
endmodule