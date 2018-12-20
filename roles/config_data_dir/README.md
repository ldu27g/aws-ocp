## 永続データ格納ディレクトリ作成用Playbook（config_data_dir）

kafka zookeeper PODから利用される永続データの格納先ディレクトリを作成する。

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

なし

### 制約条件

- ディレクトリが既に作成済みの場合は作成処理をスキップする。
- どのようなユーザー・コンテナからもディレクトリ書き込みを可能とするためパーミッションは777とする

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- 永続データディレクトリ作成用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
kafka_data_dir_state | 要 | any | char | directory | kafka永続データ格納先ディレクトリの状態<br>※directory：作成する<br>absent：削除する
kafka_data_dir_path | 要 | any | char | /data/kafka-data | kafka永続データ格納先ディレクトリパス
zoo_data_dir_state | 要 | any | char | directory | zookeeper永続データ格納先ディレクトリの状態<br>※directory：作成する<br>absent：削除する
zoo_data_dir_path | 要 | any | char | /data/zoo-data | zookeeper永続データ格納先ディレクトリパス

### 設定ファイル一覧

なし


### サンプル変数ファイル

    [ocp-infra:vars]
    kafka_data_dir_state=directory
    kafka_data_dir_path=/data/kafka-data

    zoo_data_dir_state=directory
    zoo_data_dir_path=/data/zoo-data
