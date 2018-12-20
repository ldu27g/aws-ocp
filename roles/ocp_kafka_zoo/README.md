## Kafka / Zookeeperコンテナデプロイ用Playbook（ocp-kafka-zoo）

OpenShift環境にてKafkaおよびZookeeper PODをデプロイする

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
- ocp_kafka_presentおよびocp_zoo_presentをfalseにした場合、kafkaおよびzookeeperに関連するオブジェクトのみが削除される<br>（プロジェクト自体は削除されない）。

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- kafka / zookeeper POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_user | 要 | any | char | acom | OCログイン時のログインユーザ
ocp_password | 要 | any | char | acom | OCログイン時のログインパスワード
project_name | 要 | any | char | kafka | Kafka / Zookeeperのデプロイ先プロジェクト名
ocp_kafka_present | 要 | true/false | char | true |kafka PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
ocp_zoo_present | 要 | true/false | char | true |zookeeper PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
kafka_conf_dir | 要 | any | char | /tmp/kafka |kafka設定ファイル用一時ディレクトリ
zoo_conf_dir | 要 | any | char | /tmp/zoo |zookeeper設定ファイル用一時ディレクトリ
kafka_zoo_connect | 要 | any | char | zoo1:2181,zoo2:2181,zoo3:2181 |kafkaの接続先となるzookeeperの接続情報


### 設定ファイル一覧

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
kafka-configmap.yml | 要 | file | yaml | kafka用configmapファイル
zoo-configmap.yml | 要 | file | yaml | zookeeper用configmapファイル




### サンプル変数ファイル

    [ocp-master:vars]
    ocp_user=acom
    ocp_password=acom
    project_name=kafka
    ocp_kafka_present=true
    ocp_zoo_present=true

    kafka_conf_dir=/tmp/kafka
    kafka_replica_size=3

    zoo_conf_dir=/tmp/zoo
    zoo_replica_size=3

    kafka_zoo_connect=zoo1:2181,zoo2:2181,zoo3:2181
