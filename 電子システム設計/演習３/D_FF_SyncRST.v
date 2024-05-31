module D_FF_SyncRST(D, CLK, RESET, Q);
    input D;      // D入力
    input CLK;    // クロック信号
    input RESET;  // 同期リセット信号（0の時リセット）
    output reg Q;  // 出力Q

always @(posedge CLK) begin
    if (RESET == 0) begin
        Q <= 1'b0;     // RESETが0の場合、Qを0に設定
    end else begin
        Q <= D;        // そうでなければ、Dの値はQにそのまま代入
    end
end

endmodule