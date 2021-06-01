// Code your testbench here
// or browse Examples
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
    ha = 1;
    hc = 1;
    
    @(posedge clk)
    #10 rst = 1;
    
    tm = 1;
    bb = 0;
    bp = 1;
    hm = 1;
   
    
   
    $finish();
    
  end
  initial begin
    $display("output: %b",out);
    $display("hm: %b",hm);
  end

  
endmodule