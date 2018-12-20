# OpenShift Grafana設定用Playbook（ocp-grafana）

## 参照ロール

- [ocp_grafana](http://10.248.152.169:8080/itone_shida_1/ocp-renovation/tree/release-3.9/roles/ocp_grafana)

## 前提条件

- Playbookを実行する際は、inventory「masters」グループへOpenShiftのmasterノードを設定する
- 特権ユーザー権限を使用すること

## サンプルinventoryファイル

    # Openshift OSEv3 group
    [OSEv3:children]
    masters

    # Openshift OSEv3 group vars
    [OSEv3:vars]
    # 特権ユーザー権限
    ansible_become=yes

    # Openshiftプロジェクト設定確認用変数
    openshift_grafana_namespace="openshift-grafana"
    openshift_grafana_serviceaccount_name="grafana"
    openshift_grafana_prometheus_namespace="openshift-metrics"
    openshift_grafana_prometheus_serviceaccount="prometheus"

    # Grafana データソース設定用変数
    ocp_grafana_datasource_name="ocp-prometheus"

    # Grafana ダッシュボード設定用変数
    ocp_grafana_dashboard_name="acom"

    # alertmanager configmap 設定用変数
    ocp_prometheus_alert_repeat="8h"
    ocp_fluentd_prometheus_port="8085"
    ocp_fluentd_prometheus_protocol="tcp"
    ocp_fluentd_proemtheus_service="logging-fluentd"

    # Openshift node ホスト設定
    [masters]
    ocp-master0[1:3].acom.local

## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ocp_grafana playbooks/ocp-grafana/site.yml

