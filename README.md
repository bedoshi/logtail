# logtail
Perl で access.log のようなログ・ファイルをWebアクセスで参照できるようにしたいだけのもの。<br>
TatsumakiとTwiggyを使うとかんたんにできちゃう、ってのはWebで見た。<br>
でもTatsumakiはcpanmで導入する際にdependencyに問題があるらしく、テストで失敗する。<br>
ということでリアルタイムは無理でもそれっぽいものは作ってみたい思い。

## Memo
### 起動方法
```
perl script/lite-server
```
### URLのバインドとかどこでやってる？
Dispatcher.pmを見て。

### どこまでやった？
- とりあえず静的ファイルを読み込んでページ内に出力するところまで。(`/cat` でバインドしてる) @2020/06/04時点
- server側で差分を取得して、JSON形式で返すAPIを作成した。（`/tail` でバインドしてる）@2020/06/07時点

## 参考
- [WEB上からapacheの生ログをリアルタイム？で見ることが出来るようにするWEBアプリ - @OMAKASE](http://www.omakase.org/perl/web_apache_log.html)
