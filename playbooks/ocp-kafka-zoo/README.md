# Kafka / Zookeeperコンテナデプロイ用Playbook（ocp-kafka-zoo）

## 参照ロール

- [config_data_dir](../../roles/config_data_dir/README.md)
- [ocp_kafka_zoo](../../roles/ocp_kafka_zoo/README.md)


## 前提条件

なし

## サンプルinventoryファイル

     [ocp-master]
     ocp-master01.acom.local
     [ocp-infra]
     ocp-infra0[1:3].acom.local
     [ocp-infra:vars]
     # Kafka永続データ格納先ディレクトリ作成時は「directory」、削除時は「absent」を指定する
     kafka_data_dir_state=directory
     # Kafka永続データ格納先ディレクトリの作成先パスを指定する
     kafka_data_dir_path=/data/kafka-data
     # Kafka永続データ格納先ディレクトリ作成時は「directory」、削除時は「absent」を指定する
     zoo_data_dir_state=directory
     # Kafka永続データ格納先ディレクトリの作成先パスを指定する
     zoo_data_dir_path=/data/zoo-data
     [ocp-master:vars]
     # OCコマンド実行のためのOpenShiftログインユーザ
     ocp_user=acom
     # OCコマンド実行のためのOpenShiftログインパスワード
     ocp_password=acom
     # コンテナ作成先となるプロジェクト名
     project_name=kafka
     # Kafkaコンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
     ocp_kafka_present=true
     # Zookeeperコンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
     ocp_zoo_present=true
     # Kafka設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
     kafka_conf_dir=/tmp/kafka
     # Kafkaコンテナのレプリカ数
     kafka_replica_size=3
     # Zookeeper設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
     zoo_conf_dir=/tmp/zoo
     # Zookeeperコンテナのレプリカ数
     zoo_replica_size=3
     # Kafka接続先となるZookeeperの接続情報
     kafka_zoo_connect=zoo1:2181,zoo2:2181,zoo3:2181

## 設定ファイル
 
- [ocp_kafka_zoo](../../roles/ocp_kafka_zoo/README.md)を参照し、必要に応じてfilesディレクトリにファイルを配置する

## Playbook実行コマンド

### Kafka / Zookeeperコンテナのデプロイ
    ansible-playbook -i inventory/inventory_kafka_zoo playbooks/ocp-kafka-zoo/site.yml
