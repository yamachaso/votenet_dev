# votenet_dev

make init : リソースのダウンロード

make build : コンテナのビルド

make start : コンテナの起動, 実行

make stop : コンテナの停止

make destroy : イメージの削除


## コンテナ起動
```
$ make init
$ make build
$ make start
```

## 実行
以下、コンテナ内で実行
```
$ cd ./votenet/pointnet2/
$ sudo python3 setup.py install
```
途中パスワードを聞かれるので「password」と打つ。

```
$ cd ..
$ python3 demo.py
```
