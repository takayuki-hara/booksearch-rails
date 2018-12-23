# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

  * ruby 2.5.1p57 (2018-03-29 revision 63029)
  * rails 5.2.1

* System dependencies

  * Heroku
  * PostgreSQL
  * Bootstrap4

* Configuration

* Database creation

  ``` ruby
  # Local
  rake db:create
  rails db:drop:all
  # Heroku
  # デプロイ時に作成、あるいはプラグインを追加するタイミングで作成される
  ```

* Database initialization

  ``` ruby
  # Local
  rails db:migrate
  # Heroku
  heroku run rake db:migrate
  ```

* Services (job queues, cache servers, search engines, etc.)

  * HerokuScheduler
  * SendGrid

* Deployment instructions

  ``` ruby
  # ログイン
  heroku login
  # アプリケーションの作成※初回のみ
  heroku create booksearch-bunl25ft
  # デプロイ ※develop=ソースのあるリポジトリの対象ブラウザ
  git push heroku develop:master
  # デプロイしたアプリを開く
  heroku open
  ```

* Debug instructions

  ``` ruby
  # DBサーバーの起動
  brew services start postgresql
  # Webサーバーの起動
  heroku local web
  # アプリを開く
  http://localhost:5000/
  ```

* Develop Command

  ``` ruby
  # アプリケーションの作成
  rails new booksearch —database=postgresql
  # コントローラーを追加
  rails generate controller Top index
  # モデルを追加
  rails generate model book title:string:index price:integer author:string publisher:string isbn:string caption:string sales_date:string item_url:string largeimage_url:string
  # scaffoldでまとめて作成
  rails generate scaffold apikey apikey:string
  # ローカルDBへの接続
  rails dbconsole
  # Routeの確認
  rails routes
  # Note
  rails notes
  ```
* HerokuScheduler

バッチ処理を実行するために使用しているアドオン。
アドオン自体は無料だがクレジットカード登録していないと使えない。
時間課金になり、無料枠内での利用に留めるようにする。

参考）Herokuのインスタンスをスリープさせないためのバッチ
  ``` sh
  # 9:00 - 21:00 JST (= 0:00 - 12:00 UTC) の間、起動しておきたい場合
  $ seq 0 12 | grep -qw $((10#`date -u "+%H"`)) && curl https://xxxx.herokuapp.com > /dev/null 2>&1
  ```

* SendGrid

メールを送信するために使用しているアドオン。
アドオン自体は無料だがクレジットカード登録していないと使えない。
10000通くらいまで無料なので十分。
