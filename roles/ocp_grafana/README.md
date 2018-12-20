# Openshift Grafana 設定用ロール（ocp_grafana）

Openshift上のGrafanaPODに対する設定を行う
- Prometheus データソース作成
- Grafana ダッシュボード作成、変更

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

- Openshift上にGrafanaPODがデプロイされていること
- Openshift上にPrometheusPODがデプロイされていること
- 「files/dashboards/」ディレクトリ下にダッシュボードjsonファイルを配置すること
 
## 制約条件

- 同名のデータソースが存在する場合、データソースの設定を変更しない
- 同名のGrafanaダッシュボードが存在する場合、既存のダッシュボード設定を上書きする

## 冪等性
無

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- Openshift プロジェクト設定確認用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
openshift_grafana_namespace | 否 | any | char | openshift-grafana | Grafanaの所属プロジェクト名
openshift_grafana_serviceaccount_name | 否 | any | char | grafana | Grafana PODのサービスアカウント名
openshift_grafana_prometheus_namespace | 否 | any | char | openshift-metrics | Prometheusの所属プロジェクト名
openshift_grafana_prometheus_serviceaccount | 否 | any | char | prometheus | Prometheusのサービスアカウント名

- Grafana Prometheusデータソース設定用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_grafana_datasource_name | 要 | any | char | prometheus | データソース名

- Grafana ダッシュボード設定用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
ocp_grafana_dashboard_name | 要 | any | char | acom | ダッシュボード名

# 設定ファイル一覧

- Grafana ダッシュボード設定用ファイル

ファイル名 | 要否 | type | 書式 |  説明
:--- | :--- | :--- | :--- | :---
dashbord/* | 要 | file | json | ダッシュボードjsonファイル<br>デフォルトファイル「acom」<br>デフォルトファイルを使用せず、jsonファイルへダッシュボード名を記載した場合、「ocp_grafana_dashboard_name」は無効化される


## サンプル変数ファイル
### データソース設定用
    # データソース作成
    ocp_grafana_datasource_name: "ocp-prometheus2"

### ダッシュボード設定用
    # デフォルトダッシュボード設定
    ocp_grafana_dashboard_name: "acom2"



