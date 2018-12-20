# Openshift Prometheus 設定用ロール（ocp_prometheus）

Openshift上のPrometheusに関連する設定を行う
- Prometheus iptables 設定
- Prometheus 設定(メトリクス取得設定、アラートルール設定等)
- alertmanager 設定
- Fluentd アラート連携設定
- node-exporter 設定
  
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
iptables | restart

## タグ

タグ名 | 説明
:--- | :---
- | -

## 前提条件

- Openshift上にPrometheusPODがデプロイされていること
- Openshift上にFluentdPODがデプロイされること
- PrometheusPODのサービスアカウントに「clustar-admin」権限が設定されていること
- Configmap alertmanager が存在すること
- Daemonset prometheus-node-exporter が存在すること
- Daemonset logging-fluentdが存在すること

## 制約条件

- PrometheusPODのHA構成は対応対応していない
- ロール実行後、PrometheusPODは必ず再起動される
- Configmap prometheusが存在する場合、既存のConfigmapを削除し、再作成を行う
- 同名のGrafanaダッシュボードが存在する場合、既存のダッシュボード設定を上書きする
- node-exporter連携のため9100ポートを開放する
- Fluentdアラート連携のため任意のポート1つを開放する
- Fluentdアラート連携設定を行う場合、「ocp-fluentd」Playbookを使用し、Fluentd service等を設定する必要がある(順序性なし)

## 冪等性
無

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- Openshift プロジェクト設定確認用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
openshift_prometheus_namespace | 否 | any | char | openshift-metrics | Prometheusの所属プロジェクト名
openshift_logging_namespace | 否 | any | char | logging | Fluentdの所属プロジェクト名 

- Configmap alertmanager 設定用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_prometheus_alert_repeat | 否 | any | char | 12000h | 同じアラートを再発報する間隔<br>単位(h:時間 ,m:分)
ocp_fluentd_prometheus_port | 否 | any | char | 8085 | Fluentd 接続用ポート
ocp_fluentd_prometheus_protocol | 否 | any | char | tcp | Fluentd 接続プロトコル
ocp_fluentd_proemtheus_service | 否 | any | char | logging-fluentd | Fluentd アラート連携用サービス名

## 設定ファイル一覧

- Configmap prometheus 設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
prometheus/prometheus.yml | 要 | file | yaml | Prometheus設定(メトリクス取得設定等)
prometheus/prometheus.rules | 要 | file | yaml | Prometheusアラートルール設定

- Daemonset node-exporter 設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
patch/patch_ds_prometheus-node-exporter.json | 要 | file | json | prometheus-node-exporterPOD設定変更

- Configmap alertmanager 設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
alertmanager/alertmanager.yml | 要 | template | yaml | alertmanager設定

## サンプル変数ファイル
### alertmanager 設定
    # alertmanager設定、Fluentdアラート連携設定
    ocp_prometheus_alert_repeat: 8h
    ocp_fluentd_prometheus_port: 8085
    ocp_fluentd_prometheus_protocol: tcp
    ocp_fluentd_proemtheus_service: logging-fluentd

