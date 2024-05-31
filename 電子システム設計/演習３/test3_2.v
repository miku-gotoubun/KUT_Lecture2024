module D_FF_SyncRST(D, CLK, RESET, Q);
/*** ここに「同期リセット付きD-FF」のVerilogソースを書いてシミュレーションせよ！ ***/

    input D;      // D入力
    input CLK;    // クロック信号
    input RESET;  // 同期リセット信号（0の時リセット）
    output reg Q;  // 出力Q

always @(posedge CLK) begin
    if (RESET == 0) begin
        Q <= 1'b0;     // RESETが0の場合、Qを0に設定
    end else begin
        Q<= D;        // そうでなければ、Dの値はQにそのまま代入
    end
end
/*** ここまで **********************************************************************/
	
endmodule


module D_FF_NonSyncRST(D, CLK, RESET, Q);
/*** ここに「非同期リセット付きD-FF」のVerilogソースを書いてシミュレーションせよ！ ***/
    input D;      // D入力
    input CLK;    // クロック信号
    input RESET;  // 非同期リセット信号（0の時リセット）
    output reg Q;  // 出力Q
    

always @(posedge CLK or negedge RESET) begin
    if (RESET == 0) begin
        Q <= 1'b0;     // RESETが0の場合、Qを0に設定
    end else begin
        Q <= D;        // そうでなければ、Dの値はQにそのまま代入
    end
end

/*** ここまで **********************************************************************/
endmodule


`timescale 1ns /1ns
module test;
reg inD;
reg clk;
reg _rst;

wire outQ1;
wire outQ2;

D_FF_SyncRST D_FF_SRST( .D(inD), .CLK(clk), .RESET(_rst), .Q(outQ1) );
D_FF_NonSyncRST D_FF_NSRST( .D(inD), .CLK(clk), .RESET(_rst), .Q(outQ2) );

parameter period1 = 5;	//100 MHz clock → 100MHz＝クロックサイクル時間10ns 10nsで1周期, 5nsで半周期 
always # (period1)	 clk = ~clk;  // 常に，period1=5n進めたらクロックが反転する．＝ 半周期進む． 

initial begin
  // 波形ダンプの設定
        $dumpfile("test3_2_testbenchi.vcd"); // 生成するVCDファイルの名前
        $dumpvars(0, test); // 全階層の変数をダンプ
        $monitor ("%t: clk = %b, inD = %b, _rst = %b, outQ1 = %b, outQ2 = %b", $time, clk, inD, _rst, outQ1, outQ2);
  // 初期設定
  clk = 0;
  inD = 0;
  _rst = 1;
  

  #(period1)   // 5ns進めて，clkが変化 0 → 1
  #(period1)   // 5ns進めて，clkが変化 1 → 0
  #2 inD = 1;  // 2ns進めて，inDを1へ変更
  #3           // 3ns進めて，clkが変化 0 → 1
  #1 _rst = 0; // 1ns進めて，すでにclkが1に変化済，さらに1ns経過後 _rstを0へ変更
  #4           // 4ns進めて，clkが変化 1 → 0
  #(period1)   // 5ns進めて，clkが変化 0 → 1
  #1 inD = 0;  // 1ns進めて，inDを0へ変更
  #1 _rst = 1; // 1ns進めて，_rstを1へ変更
  #3           // 3ns進めて，clkが変化 1 → 0
  #(period1)   // 5ns進めて，clkが変化 0 → 1
  #2 inD = 1;  // 2ns進めて，inDを1へ変更
  #3           // 3ns進めて，clkが変化 1 → 0
  #(period1)   // 5ns進めて，clkが変化 0 → 1
  #1 inD = 0;  // 1ns進めて，inDを0へ変更
  #4           // 4ns進めて，clkが変化 1 → 0
  #3           // 3ns進めて，終わり
  $display("finish!!");
  #50 $finish;
end
endmodule
