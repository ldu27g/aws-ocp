# Redmineインストール/設定用ロール（ls_redmine）

Linux環境にて、Redmineのインストールおよび設定を行う

- Redmine OS設定
  - SELinux無効化
  - firewalld停止/無効化
- Redmine 前提RPMパッケージのインストール
- Rubyのバイナリインストール
- Redmineのインストール
- Redmine設定
- Redmine用DBテーブルの作成
- Apache/Passengerのインストール 

## Ansibleバージョン

2.4

## プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

## 実行時のサービス影響

実行条件 | サービス影響
:--- | :---
未設定時  | OS再起動<br>※SELinuxが有効な場合のみ
既設定時  | 影響なし

## タグ

タグ名 | 説明
:--- | :---
- | -

## 前提条件

- yumリポジトリと通信可能なこと
 
## 制約条件

- ruby/gem/redmineのインストールはオフラインインストールとする
- バージョンは以下となる
  - ruby：2.4.2
  - bundler：1.16.0
  - redmine：3.4.3


## 冪等性
有

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- Redmine 作業ディレクトリ定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_work_dir | 否 | any | /tmp/redmine-setup | Redmineインストール時の作業ディレクトリ<br>※末尾「/」は不要

- Redmine テーマ定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_theme | 否 | classic / alternate / a1 | デフォルト | Redmineインストール時のテーマ<br>※初回インストール時のみ設定可

- Redmineデータベース接続定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_db_host | 否 | any | db | Redmineデータベースサーバホスト<br>※IPアドレスまたはホスト名
vars_redmine_db_name | 否 | any | redmine | Redmineデータベース名
vars_redmine_db_user | 否 | any | redmine | Redmineデータベース接続ユーザ
vars_redmine_db_user_pass | 否 | any | redmine | Redmineデータベース接続ユーザのパスワード

- Redmine SMTP定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_smtp_host | 否 | any | localhost | Redmine SMTPサーバホスト<br>※IPアドレスまたはホスト名
vars_redmine_smtp_port | 否 | any | 25 | Redmine SMTPポート
vars_redmine_smtp_domain | 否 | any | example.local | Redmine SMTPドメイン名

- Ruby/Gemソース定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_ruby_path | 否 | any | /usr/local/bin/ruby | Rubyインストールパス<br>※末尾「/」は不要
vars_redmine_ruby_src | 否 | any | ruby-2.4.2.tar.gz | Rubyソースファイル名
vars_redmine_ruby_archive_ext | 否 | any | tar.gz | Rubyソースファイル拡張子
vars_redmine_gem_bundler_file | 否 | any | bundler-1.16.0.gem | bundler gemファイル名

- Redmineデプロイ定義変数

変数名 | 要否 | 選択肢 | デフォルト | 説明
:--- | :--- | :--- | :--- | :---
vars_redmine_dir | 否 | any | /var/lib/redmine | Redmineのデプロイ先ディレクトリパス<br>※末尾「/」は不要<br>※本ディレクトリ配下にRedmineソースが展開される
vars_redmine_src | 否 | any | redmine-3.4.3.tar.gz | Redmineソースファイル名
vars_redmine_dir_owner | 否 | any | apache | Redmineのデプロイ先ディレクトリのオーナー<br>※apahce実行ユーザを指定する
vars_redmine_dir_group | 否 | any | apache | Redmineのデプロイ先ディレクトリのグループ<br>※apahce実行ユーザを指定する
vars_redmine_font_path | 否 | any | /usr/share/fonts/truetype/takao-gothic/TakaoPGothic.ttf | Redmineの使用フォント配置パス



## サンプル変数ファイル

    # データベースの redmine ユーザーのパスワード
    vars_redmine_db_host: db
    vars_redmine_db_name: redmine
    vars_redmine_db_user: redmine
    vars_redmine_db_user_pass: redmine

    # Redmineデータベースのテーブル作成要否(true:作成する,false:作成しない)
    #vars_redmine_db_create=true

    # SMTP設定
    vars_redmine_smtp_host: localhost
    vars_redmine_smtp_port: 25
    vars_redmine_smtp_domain: example.local

    # 作業ディレクトリ
    vars_redmine_work_dir: /tmp/redmine-setup

    # ダウンロードするRubyのソースコード
    vars_redmine_ruby_path: /usr/local/bin/ruby
    vars_redmine_ruby_src: ruby-2.4.2.tar.gz
    vars_redmine_ruby_archive_ext: tar.gz
    vars_redmine_gem_bundler_file: bundler-1.16.0.gem

    # Redmineのデプロイ先ディレクトリ
    vars_redmine_dir: /var/lib/redmine
    vars_redmine_src: redmine-3.4.3.tar.gz

    # Redmineのデプロイ先ディレクトリのオーナー:グループ
    vars_redmine_dir_owner: apache
    vars_redmine_dir_group: apache

    # Redmineで使用する日本語フォントファイル
    vars_redmine_font_path: /usr/share/fonts/truetype/takao-gothic/TakaoPGothic.ttf

