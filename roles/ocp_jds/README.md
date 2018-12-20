## JDSコンテナデプロイ用Playbook（ocp-jds）

OpenShift環境にてJDS PODをデプロイする

### Ansibleバージョン

2.4

### OpenShiftバージョン

3.9

### プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

### 実行時のサービス影響

無し

### タグ

タグ名 | 説明
:--- | :---
- | -

### 前提条件

- 実行対象サーバにてOCコマンドが使用可能なこと
- RedHat社提供Playbook(openshift-ansible)によるOpenShift v3.9のインストールを行った環境にて実施すること

### 制約条件

- 同名のOpenShiftオブジェクトがあった場合、当該オブジェクトに対する作成処理はスキップされる
- ocp_jds_presentをfalseにした場合、JDSに関連するオブジェクトのみが削除される（プロジェクト自体は削除されない）。

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- JDS POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_user | 要 | any | char | acom | OCログイン時のログインユーザ
ocp_password | 要 | any | char | acom | OCログイン時のログインパスワード
project_name | 要 | any | char | jboss | JDSのデプロイ先プロジェクト名
ocp_jds_present | 要 | true/false | char | true |JDS PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
jds_conf_dir | 要 | any | char | /tmp/jds |JDS設定ファイル用一時ディレクトリ
jds_input_is_name | 要 | any | char | decisionserver64-openshift |バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
jds_input_is_version | 要 | any | char | 1.0 |バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
jds_image_import_repo | 要 | any | char | 10.248.152.200:5000/jboss-decisionserver-6/decisionserver64-openshift:1.3 |S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
jds_build_name | 要 | any | char | decisionserver-app |バイナリビルドする際のビルド名


### バイナリファイルの配置

files/binaryディレクトリにアプリケーションバイナリファイル（*.war）を配置することで、当該ディレクトリ配下のバイナリがすべてデプロイされる。


### サンプル変数ファイル

    # OCコマンド実行のためのOpenShiftログインユーザ
    ocp_user=acom
    # OCコマンド実行のためのOpenShiftログインパスワード
    ocp_password=acom
    # コンテナ作成先となるプロジェクト名   
    project_name=jboss
    # コンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
    ocp_jds_present=false
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    jds_conf_dir=/tmp/jds
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
    jds_input_is_name=decisionserver64-openshift
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    jds_input_is_version=1.0
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    jds_image_import_repo=10.248.152.200:5000/jboss-decisionserver-6/decisionserver64-openshift:1.3
    # バイナリビルドする際のビルド名
    jds_build_name=decisionserver-app
