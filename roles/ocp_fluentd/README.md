# Openshift Fluentd 設定用ロール（ocp_fluentd）

Openshift上のFluentdに関連する設定を行う
- Fluentd Configmap 設定
- Prometheus アラート連携 設定
  
## Ansibleバージョン

2.4

## Openshiftバージョン

3.9

## プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

## 実行時のサービス影響

実行条件 | サービス影響
:--- | :---
- | -

## タグ

タグ名 | 説明
:--- | :---
- | -

## 前提条件

- Openshift上にFluentdPODがデプロイされること
- Openshift上にPrometheusPODがデプロイされていること
- Daemonset logging-fluentdが存在すること

## 制約条件

- Configmap logging-fluentdが存在する場合、既存のConfigmapを削除し、再作成を行う
- Fluentd連携のため任意のポート1つを開放する
- Pormetheusアラート連携設定を行う場合、「ocp-prometheus」Playbookを使用し、Configmap alertmanagerを設定する必要がある(順序性なし)

## 冪等性
無

## 設定反映タイミング
タスク実行

## 入力変数一覧

- Openshift プロジェクト設定確認用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
openshift_logging_namespace | 否 | any | char | logging | Fluentdの所属プロジェクト名
openshift_prometheus_namespace | 否 | any | char | openshift-metrics | Prometheusの所属プロジェクト名

- Prometheus アラート連携設定用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_fluentd_prometheus_port | 否 | any | char | 8085 | Fluentd 接続用ポート
ocp_fluentd_prometheus_protocol | 否 | any | char | tcp | Fluentd 接続プロトコル
ocp_fluentd_proemtheus_service | 否 | any | char | logging-fluentd | Fluentd アラート連携用サービス名

## 設定ファイル一覧

- Fluentd Configmap設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
logging-fluentd/* | 要 | file | yaml | Configmap設定ファイル<br>ファイル名をConfigmap内のファイル名として登録する

- Prometheus 連携設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
patch/patch_service_logging-fluentd.json | 要 | file | json | Fluentd連携用サービス設定変更
svc_fluentd/create_service_fluentd.yml | 要 | file | yaml | Fluentd連携用サービス設定


## サンプル変数ファイル
### Prometheus アラート連携設定
    # logging-fluentd service 設定
    ocp_fluentd_prometheus_port: 8085
    ocp_fluentd_prometheus_protocol: tcp
    ocp_fluentd_proemtheus_service: logging-fluentd

