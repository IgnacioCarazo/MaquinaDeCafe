`timescale 1ns / 1ps
module tb_maquina_de_cafe;
  
  reg clk, rst;
  reg hm, ha, bp, bc, bt, hc, md, mc;
  // hay moneda, hay agua, boton pulsado, boton cafe, boton te, hay cafe, moneda diez, moneda cinco
  wire [2:0] out;
  
  //instancia
  maquina_de_cafe U1(
    .clk(clk), .rst(rst),
    .hm(hm), .ha(ha), .bp(bp), .bc(bc), .bt(bt), .hc(hc), .md(md), .mc(mc),
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
    bt = 0;
    bc = 0;
    hc = 0;
    md = 0;
    mc = 0;
    
    
    // Caso 6: Se ingresa la moneda, hay agua, boton de te, moneda de 10
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
    bt = 1;
    
    @(posedge clk)
    #5 md = 1;
    
    #10
    
    hm = 0;
    ha = 0;
    bp = 0;
    bt = 0;
    bc = 0;
    hc = 0;
    md = 0;
    mc = 0;
   
    #100
    $finish;
  end
endmodule