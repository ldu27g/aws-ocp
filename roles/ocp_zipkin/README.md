## Zipkinコンテナデプロイ用Playbook（ocp-zipkin）

OpenShift環境にてZipkin PODをデプロイする

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
- ocp_zipkin_presentをfalseにした場合、zipkinに関連するオブジェクトのみが削除される（プロジェクト自体は削除されない）。

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- zipkin POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_user | 要 | any | char | acom | OCログイン時のログインユーザ
ocp_password | 要 | any | char | acom | OCログイン時のログインパスワード
project_name | 要 | any | char | zipkin | zipkinのデプロイ先プロジェクト名
ocp_zipkin_present | 要 | true/false | char | true |zipkin PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
zipkin_conf_dir | 要 | any | char | /tmp/zipkin |zipkin設定ファイル用一時ディレクトリ
zipkin_replica_size | 要 | any | char | 3 |zipkin PODのレプリカ数
zipkin_storage_type | 要 | any | char | elasticsearch |zipkinのデータ出力先ストレージ
zipkin_es_hosts | 要 | any | char | https://logging-es.logging.svc.cluster.local:9200 |zipkin_storage_typeに指定したelasticsearchのホスト名
zipkin_java_opts | 要 | any | char | -Djavax.net.ssl.trustStore=/var/run/secrets/java.io/keystores/truststore.jks <br>-Djavax.net.ssl.trustStorePassword=changeit <br>-Djava.security.egd=file:/dev/./urandom |zipkinにelasticsearch用のtruststoreを設定するためのJAVAオプション
zipkin_requests_cpu | 要 | any | char | 0 |要求CPU数
zipkin_requests_memory | 要 | any | char | 0 |要求メモリ数
zipkin_limit_cpu | 要 | any | char | 0 |制限CPU数
zipkin_limit_memory | 要 | any | char | 0 |制限メモリ数



### 設定ファイル一覧

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
service.yml | 要 | file | yaml | zipkin用serviceファイル
route.yml | 要 | file | yaml | zipkin用routeファイル
deploymentconfig.j2 | 要 | template | yaml | zipkin用deploymentconfigファイル




### サンプル変数ファイル

    ocp_user=acom
    ocp_password=acom
    project_name=zipkin
    ocp_zipkin_present=true

    zipkin_conf_dir=/tmp/zipkin
    zipkin_replica_size=3
    zipkin_storage_type=elasticsearch
    zipkin_es_hosts=https://logging-es.logging.svc.cluster.local:9200
    zipkin_java_opts=-Djavax.net.ssl.trustStore=/var/run/secrets/java.io/keystores/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit -Djava.security.egd=file:/dev/./urandom
    zipkin_requests_cpu=0
    zipkin_requests_memory=0
    zipkin_limit_cpu=0
    zipkin_limit_memory=0
