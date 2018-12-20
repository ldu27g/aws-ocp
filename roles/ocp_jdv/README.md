## JDVコンテナデプロイ用Playbook（ocp-jdv）

OpenShift環境にてJDV PODをデプロイする

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
- ocp_jdv_presentをfalseにした場合、jdvに関連するオブジェクトのみが削除される（プロジェクト自体は削除されない）。

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- JDV POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_user | 要 | any | char | acom | OCログイン時のログインユーザ
ocp_password | 要 | any | char | acom | OCログイン時のログインパスワード
project_name | 要 | any | char | jboss | JDVのデプロイ先プロジェクト名
ocp_jdv_present | 要 | true/false | char | true |JDVPODのデプロイ状態<br>※true：デプロイする<br>false：削除する
jdv_conf_dir | 要 | any | char | /tmp/jdv |JDV設定ファイル用一時ディレクトリ
jdv_replica_size | 要 | any | char | 3 |jdv PODのレプリカ数
jdv_git_pull_user_name | 要 | any | char | itone_shida_1 |S2Iビルドに使用するソースコードリポジトリにアクセスするためのユーザ
jdv_git_pull_password | 要 | any | char | 12qwaszx |S2Iビルドに使用するソースコードリポジトリにアクセスするためのパスワード
jdv_input_is_name | 要 | any | char | jboss-datavirt64-openshift |S2Iビルドする際にインプットとなるベースイメージのイメージストリーム名
jdv_input_is_version | 要 | any | char | 1.0 | S2Iビルドする際にインプットとなるベースイメージのイメージストリームバージョン
jdv_output_is_name | 要 | any | char | datavirt-app |S2Iビルド結果を保持するアウトプット先イメージストリーム名
jdv_image_import_repo | 要 | any | char | 10.248.152.200:5000/jboss-datavirt-6/datavirt64-openshift:1.0 |S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
jdv_template_name | 要 | any | char | datavirt64-basic-s2i-acom |S2Iビルドおよびアプリケーション作成で利用するOpenShiftテンプレート名
jdv_apl_name | 要 | any | char | datavirt-app |JDVのアプリケーション名（ビルド名や各種オブジェクト名としても利用する）
jdv_src_repo_uri | 要 | any | char | http://10.248.152.169:8080/git/itone_shida_1/sample-jdv.git |S2Iビルドする際のソースコードリポジトリURL
jdv_src_repo_branch | 要 | any | char | master |S2Iビルドする際のソースコードリポジトリのブランチ名
jdv_resource_limit_memory | 要 | any | char | 1Gi |JDV PODのメモリ制限
jdv_output_is_namespace | 要 | any | char | jboss |S2Iビルドした結果のイメージストリーム作成先となるプロジェクト名
jdv_template_param |  | any | char |  |JDVのOpenShisftテンプレート内で利用している各種変数を変更したい場合に-p key=valueで指定する（-p key=valueのセットを複数指定可能）


### 設定ファイル

- 設定ファイル一覧

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
.gitconfig | 要 | file | ini | gitbukectアクセス用.gitconfigファイル。gitbukectの接続設定を変更する場合は内容を修正する。デフォルトでsslverify=falseを設定している。
datasource.env | 要 | file | key=value | JDVのデータソース設定用envファイル。DB接続先URL、ユーザアカウント等、接続情報に応じて内容を修正する。
jgroups.jceks | 要 | file | jceks | JDVの暗号鍵ストア
keystore.jks | 要 | file | jks | JDVのキーストア
template.j2 | 要 | template | yaml | JDV用templateファイル

### サンプル変数ファイル

    [ocp-master:vars]
    # OCコマンド実行のためのOpenShiftログインユーザ
    ocp_user=acom
    # OCコマンド実行のためのOpenShiftログインパスワード
    ocp_password=acom
    # コンテナ作成先となるプロジェクト名
    project_name=jboss
    # コンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
    ocp_jdv_present=true
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    jdv_conf_dir=/tmp/jdv
    # S2Iビルドに使用するソースコードリポジトリにアクセスするためのユーザ
    jdv_git_pull_user_name=itone_shida_1
    # S2Iビルドに使用するソースコードリポジトリアクセスユーザのパスワード
    jdv_git_pull_password=12qwaszx
    # S2Iビルドする際にインプットとなるベースイメージのイメージストリーム名
    jdv_input_is_name=jboss-datavirt64-openshift
    # S2Iビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    jdv_input_is_version=1.0
    # S2Iビルド結果を保持するアウトプット先イメージストリーム名
    jdv_output_is_name=datavirt-app
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    jdv_image_import_repo=10.248.152.200:5000/jboss-datavirt-6/datavirt64-openshift:1.0
    # S2Iビルドおよびアプリケーション作成で利用するOpenShiftテンプレート名
    jdv_template_name=datavirt64-basic-s2i-acom
    # JDV PODのレプリカ数
    jdv_replica_size=3
    # JDVのアプリケーション名（ビルド名や各種オブジェクト名としても利用する）
    jdv_apl_name=datavirt-app
    # S2Iビルドする際のソースコードリポジトリURL
    jdv_src_repo_uri=http://10.248.152.169:8080/git/itone_shida_1/sample-jdv.git
    # S2Iビルドする際のソースコードリポジトリのブランチ名
    jdv_src_repo_branch=master
    # JDV PODのメモリ制限
    jdv_resource_limit_memory=1Gi
    # S2Iビルドした結果のイメージストリーム作成先となるプロジェクト名
    jdv_output_is_namespace=jboss
    # JDVのOpenShisftテンプレート内で利用している各種変数を変更したい場合に-p key=valueで指定する（-p key=valueのセットを複数指定可能）
    jdv_template_param=''
