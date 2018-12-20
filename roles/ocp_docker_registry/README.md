## Openshift Docker Registry 永続ボリューム設定用ロール（ocp_docker_registry）

OpenShift環境にデプロイされているInternal Docker Registryに対し、HostPathによる永続ボリュームをマウントする。
- Docker Registry POD配置先ノードへの永続先ディレクトリの作成
- Docker Registry POD配置先ノードへのラベルの付与
- サービスアカウントの権限設定
- docker registryのdeploymentconfigの編集
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
- Docker Registry PODがデプロイされていること

### 制約条件

- 「vars_ocp_docker_registry_node」に指定してノードに対し、「vars_ocp_docker_registry_volume」で指定したボリューム(ディレクトリ)
を作成する
- opemshift-ansibleによりデプロイされたDocker Registry PODは、インストール時に指定されたラベルが付与されたノードに配置される。<br>
変数「vars_ocp_docker_registry_nodeselector」に指定したラベルはDocker Registry PODのdeplaymentconfigのnodeselectorに追記されため、<br>
PODはインストール時に付与されたラベルおよび、変数「vars_ocp_docker_registry_nodeselector」で指定したラベルが両方付与されたノードにデプロイされる。

### 冪等性
以下項目の設定につき冪等性無し
※ただし、最終的な設定状態の冪等性は担保される(何度実行しても同じ設定となる)
- ノードへのラベル付与
- サービスアカウントへのSCC付与
- PODへのボリュームマウント

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- Dokcer Registry POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ocp_docker_registry_volume.hostpath | 要 | any | char | /data/docker-vol | PODの永続先ボリューム(ディレクトリ)<br>※Registryデータの保存先
vars_ocp_docker_registry_volume.mode | 要 | any | char | 0777 | PODの永続先ボリューム(ディレクトリ)のパーミッション
vars_ocp_docker_registry_volume.owner | 要 | any | char | root | PODの永続先ボリューム(ディレクトリ)のオーナー
vars_ocp_docker_registry_volume.group | 要 | any | char | - | PODの永続先ボリューム(ディレクトリ)のグループ
vars_ocp_docker_registry_node | 要 | any | char | ocp-infra01.acom.local | PODを配置先するノード
vars_ocp_docker_registry_nodeselector | 要 | any | char | docker-registry=present | PODを配置先するノードに付与するラベル
vars_ocp_docker_registry_project | 要 | any | char | default | PODのデプロイ先プロジェクト
vars_ocp_docker_registry_sa_name | 要 | any | char | registry | PODの起動用サービスアカウント
vars_ocp_docker_registry_sa_scc | 要 | any | char | privileged | PODの起動用サービスアカウントのSCC


### 入力ファイル一覧

無し

### サンプル変数ファイル

    vars_ocp_docker_registry_volume:
      - hostpath: "/data/docker-vol"
        mode: "0777"
        owner: "root"
        group: "root"
    vars_ocp_docker_registry_node: "ocp-infra01.acom.local"
    vars_ocp_docker_registry_nodeselector: "docker-registry=present"
    vars_ocp_docker_registry_project: "default"
    vars_ocp_docker_registry_sa_name: "registry"
    vars_ocp_docker_registry_sa_scc: "privileged"
