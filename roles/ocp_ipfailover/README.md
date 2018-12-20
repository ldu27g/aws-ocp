## IP-failover PODデプロイ用ロール（ocp_ipfailover）

OpenShift環境にてIP-failover PODをデプロイする

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
- RedHat社提供Playbook(openhift-ansible)によるOpenShift v3.9のインストールを行った環境にて実施すること
- keepalivedの仮想IPアドレスに指定するIPアドレスが確保されていること(未使用であること)

### 制約条件

無し

### 冪等性
有

## 設定反映タイミング
タスク実行後

### 入力変数一覧

- ipfailover POD定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ocp_ipf_present | 要 | true/false | char | true | PODのデプロイ状態<br>※true：デプロイする<br>false：削除する
vars_ocp_ipf_project | 要 | any | char | default | PODのデプロイ先プロジェクト
vars_ocp_ipf_replicas | 要 | any | char | char | PODのレプリカ数
vars_ocp_ipf_nodeselector | 要 | any | char | - | PODを配置先するノードに付与されたラベル
vars_ocp_ipf_port | 要 | any | char | 80 | ヘルスチェックポート
vars_ocp_ipf_vips | 要 | any | char | - | keepalivedの仮想IPアドレス<br>※カンマ区切りで複数指定可能
vars_ocp_ipf_image | 要 | any | char | 10.248.152.200:5000/openshift3/ose-keepalived-ipfailover:v3.9.30 | PODイメージの取得先URL

### 入力ファイル一覧

無し

### サンプル変数ファイル
    vars_ocp_ipf_present: "true"
    vars_ocp_ipf_project: "default"
    vars_ocp_ipf_replicas: "2"
    vars_ocp_ipf_nodeselector: "region=infra"
    vars_ocp_ipf_port: "80"
    vars_ocp_ipf_vips: "192.168.0.1,192.168.0.2"
    vars_ocp_ipf_image: "10.248.152.200:5000/openshift3/ose-keepalived-ipfailover:v3.9.30"
