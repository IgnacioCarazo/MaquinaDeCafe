`timescale 1ns / 1ps
module tb_maquina_de_cafe;
  
  reg clk, rst;
  reg hm, ha, bp, bb, hc, tm;
  // hay moneda, hay agua, boton pulsado, boton bebida, hay cafe, tipo de moneda
  wire [2:0] out;
  
  //instancia
  maquina_de_cafe U1(
    .clk(clk), .rst(rst),
    .hm(hm), .ha(ha), .bp(bp), .bb(bb), .hc(hc), .tm(tm),
    .out(out)
);
  
  initial begin
    
    $dumpfile("maquina_de_cafe.vcd");
    $dumpvars(0,tb_maquina_de_cafe);
  end
  
  always #10 clk =~ clk;
  
  initial begin
    clk = 0;
    rst = 0;
    hm = 0;
    ha = 0;
    bp = 0;
    bb = 0;
    hc = 0;
    tm = 0;
    
    
    // Caso 3: Se ingresa la moneda, hay agua, boton de te, moneda de 10
    // Estado Final: Servir Te y Devolver 5 (1001)
    // Output: Devolver Moneda (101)
    @(posedge clk)
    #5 rst = 1;
    
    @(posedge clk)
    #5 hm = 1;
    
    @(posedge clk)
    hm = 0;
    #5 ha = 1;
    
    @(posedge clk)
    #5 bp = 1;
    bb = 1;
    
    @(posedge clk)
    #5 tm = 1;
   
    #100
    $finish;
  end
endmodule