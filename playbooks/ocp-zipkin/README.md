# Zipkinコンテナデプロイ用Playbook（ocp-zipkin）

## 参照ロール

- [ocp_zipkin](../../roles/ocp_zipkin/README.md)


## 前提条件

- ElasticSearchがOpenShift上にデプロイされていること

## サンプルinventoryファイル

    [ocp-master]
    ocp-master01.acom.local
    [ocp-master:vars]
    # OCコマンド実行のためのOpenShiftログインユーザ
    ocp_user=acom
    # OCコマンド実行のためのOpenShiftログインパスワード
    ocp_password=acom
    # コンテナ作成先となるプロジェクト名
    project_name=zipkin
    # コンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
    ocp_zipkin_present=true
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    zipkin_conf_dir=/tmp/zipkin
    # コンテナのレプリカ数
    zipkin_replica_size=3
    # Zipkinのバックエンドストレージとしてelasticsearchを指定する
    zipkin_storage_type=elasticsearch
    # Zipkinのバックエンドストレージとしてelasticsearchを指定する場合にそのURLを指定する
    zipkin_es_hosts=https://logging-es.logging.svc.cluster.local:9200
    # elasticsearchにアクセスするためのtruststoreを認識させるためのjavaオプションを指定する
    zipkin_java_opts=-Djavax.net.ssl.trustStore=/var/run/secrets/java.io/keystores/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit -Djava.security.egd=file:/dev/./urandom
    # 要求CPU数を指定する
    zipkin_requests_cpu=0
    # 要求メモリ数を指定する
    zipkin_requests_memory=0
    # 制限CPU数を指定する
    zipkin_limit_cpu=0
    # 制限メモリ数を指定する
    zipkin_limit_memory=0

## 設定ファイル
 
- [ocp_zipkin](../../roles/ocp_zipkin/README.md)を参照し、必要に応じてfilesディレクトリにファイルを配置する


## Playbook実行コマンド

### Zipkinコンテナのデプロイ
    ansible-playbook -i inventory/inventory_zipkin playbooks/ocp-zipkin/site.yml
