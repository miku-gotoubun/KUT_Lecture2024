D_FF_SyncRST→同期リセット付きD-FF
D_FF_NonSyncRST→非同期リセット付きD-FF

両方ともコンパイル済

test3_2は上記２つのverilogHDLのテストベンチである。

注意事項！！
iverilogの場合は、テストベンチで$stop関数を消して、$finish関数を使う。
modelsimの場合は、テストベンチで$finish関数を消して、$stop関数を使うこと。

【理由】
テストベンチに置いて、$stop関数を使うと、iverilogの場合は途中停止になってターミナルに戻ってきません。
$finish関数を使うと安全に終了してコマンドに戻ります。
もし、modelsimでシミュレーションする場合、$stopで途中停止になるため、引き続きmodelsimを使うことができます。
その後の編集が可能になります。$finish関数の場合は、modelsimアプリケーションが終了してしまい続きの処理ができなくなります。
