# manaba 関連

朝日ネットの LMS、[manaba](https://manaba.jp) に関するいろんな情報まとめ。  
学生だったが、manaba からのデータ移行時にもお手伝いしたので教員側の話を含んだりしている。  
バージョンは `2.971`。すでに所属大学で manaba を使わなくなったので、最新バージョンがどうなっているかはわからない。

学生向けの公式ドキュメントは [これ](https://doc.manaba.jp/doc/course2-manual/student2.971/ja/)、教員向けの公式ドキュメントは [これ](https://doc.manaba.jp/doc/course2-manual/teacher2.971/ja/)。

## Tips

- manaba からのリマインドメールは `do-not-reply@manaba.jp` から来る。
- 価格体系は純粋に払い出される ID の数だけでなく、基本となるものに追加して有償で機能をオプション追加できるシステムらしい。アンケート機能とかがそれなのかな？
- respon という出席登録アプリケーション / サービスのオプションがある。位置情報を拾って、ほかの出席者と極端に離れていたりしたらバツになる…とか聞いたが、正直かなり眉唾だと思っている。だったら Web から出せるのおかしいし。
- [GitHub で manaba と検索をかける](https://github.com/search?q=manaba&type=repositories) と、結かまいろんなリポジトリが出てくる。

## ライブラリ

すでにメンテナンスを終えているが manaba の情報を拾うためのスクレイピング Python ライブラリ [book000/get-manaba](https://github.com/book000/get-manaba) を作っていたことがある。

## エクスポート

manaba のデータのうち、次のものはエクスポートできる。

- 小テスト
- アンケート
- レポート
- プロジェクト
- コースコンテンツ

それぞれ、アイテムの「管理」→「エクスポート」から個別のエクスポートが可能。アンケートとプロジェクト以外なら zip ファイルによる一括エクスポートも可能。
エクスポートファイルは [MHTML](https://ja.wikipedia.org/wiki/MHTML) という形式で出力される。[mht-parser.ts](https://github.com/book000/memo/blob/main/docs/etc/mht-parser.ts) という自作パーサを使うことで、これをパースできる。  
ちなみにこのパーサを使ってエクスポートファイルを処理して実際の問題のように見ることができるビュアーを作った。  
大学に投げたのでさすがに公開することは避けるが…。
