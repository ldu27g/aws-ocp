## JBoss Fuseコンテナデプロイ用Playbook（ocp-fuse-eap）

OpenShift環境にてJBoss Fuse PODをデプロイする

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
- ocp_fuse_eap_presentをfalseにした場合、JBoss Fuseに関連するオブジェクトのみが削除される（プロジェクト自体は削除されない）。

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- Fuse POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_user | 要 | any | char | acom | OCログイン時のログインユーザ
ocp_password | 要 | any | char | acom | OCログイン時のログインパスワード
project_name | 要 | any | char | jboss | Fuseのデプロイ先プロジェクト名
ocp_fuse_eap_present | 要 | true/false | char | true |Fuse PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
fuse_conf_dir | 要 | any | char | /tmp/fuse_on_eap |Fuse設定ファイル用一時ディレクトリ
fuse_eap_binary_name | 要 | any | char | ROOT.war |バイナリビルドに利用するバイナリ名
fuse_eap_input_is_name | 要 | any | char | jboss-fuse70-eap-openshift |バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
fuse_eap_input_is_version | 要 | any | char | 1.0 |バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
fuse_eap_image_import_repo | 要 | any | char | 10.248.152.200:5000/fuse7/fuse-eap-openshift:1.0 |S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
fuse_eap_build_name | 要 | any | char | fuse-app |バイナリビルドする際のビルド名


### 設定ファイル一覧

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
ROOT.war | 要 | file | war | バイナリビルドに利用するバイナリファイル


### サンプル変数ファイル

    # OCコマンド実行のためのOpenShiftログインユーザ
    ocp_user=acom
    # OCコマンド実行のためのOpenShiftログインパスワード
    ocp_password=acom
    # コンテナ作成先となるプロジェクト名   
    project_name=jboss
    # コンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
    ocp_fuse_eap_present=false
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    fuse_eap_conf_dir=/tmp/fuse_on_eap
    # バイナリビルドに利用するバイナリ名
    fuse_eap_binary_name=ROOT.war
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
    fuse_eap_input_is_name=jboss-fuse70-eap-openshift
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    fuse_eap_input_is_version=1.0
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    fuse_eap_image_import_repo=10.248.152.200:5000/fuse7/fuse-eap-openshift:1.0
    # バイナリビルドする際のビルド名
    fuse_eap_build_name=fuse-app
