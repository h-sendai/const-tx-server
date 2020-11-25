# const-tx-server

定数レートでデータを送ろうとするサーバー。

```
% ./const-tx-server -h
Usage: const-tx-server [-t rate] [-b buffer_size] [-i listen_ip_address] [-p port]
Options:
    -t rate       transfer rate (bytes/s).  use suffix k for kilo, m for mega
    -b bufsize    buffer size (bytes) for one write(). use suffix k for kilo, m for mega
    -i ip_address default is listening all interfaces
    -p port       port number
Default values:
    rate    8kB/s (DEFAULT_BYTES_RATE)
    bufsize 1kB   (DEFAULT_BUFSIZE)
    port    2222  (DEFAULT_PORT)
```

アルゴリズムは単純で

- 時刻を取得する。
- データを送る。何バイト送ったか記録しておく。
- 時刻を取得する。前回取得した時刻との差から指定された転送レートにするためにusleep()する時間を計算し、usleep()する

というもの。
usleep()する時間の計算に使う転送バイト数は開始時からのものを使うことでわりと
正確な値がでる。

このアルゴリズムはcstream
https://www.cons.org/cracauer/cstream.html
からもらってきた。

## 送るデータの変更

バッファ全体を 'X' (0x58)でうめてデータとして送っている。

prepare_send_data.cの中の

``
int prepare_send_data(char *buf, int buflen)
``

を実装することで送るデータを変更することができる。

DAQ-Middlewareに添付しているdaqmw-emulatorでの実装を参考のために
prepare_send_data.sample.c
として入れてある。

## 履歴

DAQ-Middleware付属のdaqmw-emulatorをコピーして変更した。
変更点

- オプションの変更。-h ip_addressでlistenするIPアドレスを指定していたが-iに変更した。
- オプションの変更。-hでusageを出すようにした。
- prepare_send_data()の変更。バッファ全体を 'X' で埋めるようにした。
