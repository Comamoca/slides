- WasmとはWeb上で専用のアセンブリを実行するための環境の総称
- 最近ではWeb上だけではなくローカルでも実行可能な**Wasmer**というプロダクトが出ている
- またWasmerは**WASI**というWasmから外部のIOを操作できるAPIを提唱したり、POSIX準拠の**WASIX**というものを発表している

Wasmerには専用のレジストリ[wapm]()というのがあり、それにLuaが登録されているため、Wasmから手軽に実行できる
