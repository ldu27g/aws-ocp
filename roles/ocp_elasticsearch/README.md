## Openshift Elasticsearch 永続ボリューム設定用ロール（ocp_elasticsearch）

OpenShift環境でデプロイされているElasticsearchに対し、HostPathによる永続ボリュームをマウントする。
- Elasticsearch POD配置先ノードへの永続先ディレクトリの作成
- Elasticsearch POD配置先ノードへのラベルの付与
- サービスアカウントの権限設定
- Elasticsearchのdeploymentconfigの編集
 - Security Context Constraints(SCC)の設定
 - NodeSelectorの設定
 - volumeの追加

### Ansibleバージョン

2.4

### OpenShiftバージョン

3.9

### プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

### 実行時のサービス影響

設定変更時はPODが再デプロイされる

### タグ

タグ名 | 説明
:--- | :---
- | -

### 前提条件

- 実行対象サーバにてOCコマンドが使用可能なこと
- RedHat社提供Playbook(openhift-ansible)によるOpenShift v3.9のインストールを行った環境にて実施すること
- Elasticsearch PODがデプロイされていること

### 制約条件

opemshift-ansibleによりデプロイされたElasticsearch PODは、インストール時に指定されたラベルが付与されたノードに配置される。<br>
変数「vars_ocp_elasticsearch_nodeselector」に指定したラベルはElasticsearch PODのdeplaymentconfigのnodeselectorに追記されため、<br>
PODはインストール時に付与されたラベルおよび、変数「vars_ocp_elasticsearch_nodeselector」で指定したラベルが両方付与されたノードにデプロイされる。

### 冪等性
無し<br>
※role実行時は毎回Elasticsearch PODが再デプロイされる<br>
※以下項目の冪等性は無いが、実行結果はChangedとなる
- サービスアカウントへのSCC付与
- PODへのボリュームマウント

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- Elasticsearch POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ocp_elasticsearch_volume.hostpath | 要 | any | char | /data/elastic-vol | PODの永続先ボリューム(ディレクトリ)<br>※Registryデータの保存先
vars_ocp_elasticsearch_volume.mode | 要 | any | char | 0777 | PODの永続先ボリューム(ディレクトリ)のパーミッション
vars_ocp_elasticsearch_volume.owner | 要 | any | char | root | PODの永続先ボリューム(ディレクトリ)のオーナー
vars_ocp_elasticsearch_volume.group | 要 | any | char | - | PODの永続先ボリューム(ディレクトリ)のグループ
vars_ocp_elasticsearch_nodeselector | 要 | any | char | logging-infra=elasticsearch | PODを配置先するノードに付与するラベル
vars_ocp_elasticsearch_project | 要 | any | char | logging | PODのデプロイ先プロジェクト
vars_ocp_elasticsearch_sa_name | 要 | any | char | aggregated-logging-elasticsearch | PODの起動用サービスアカウント
vars_ocp_elasticsearch_sa_scc | 要 | any | char | privileged | PODの起動用サービスアカウントのSCC


### 入力ファイル一覧

無し

### サンプル変数ファイル

    vars_ocp_elasticsearch_volume:
      - hostpath: "/data/elastic-vol"
        mode: "0000"
        owner: "root"
        group: "root"
    vars_ocp_elasticsearch_nodeselector: "logging-infra=elasticsearch"
    vars_ocp_elasticsearch_project: "logging"
    vars_ocp_elasticsearch_sa_name: "aggregated-logging-elasticsearch"
    vars_ocp_elasticsearch_sa_scc: "privileged"
