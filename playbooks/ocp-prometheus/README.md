# OpenShift Prometheus設定用Playbook（ocp-prometheus）

## 参照ロール

- [ocp_prometheus](http://10.248.152.169:8080/itone_shida_1/ocp-renovation/tree/release-3.9/roles/ocp_prometheus)

## 前提条件

- Playbookを実行する際は、inventory「masters」グループへmasterノード、「nodes」グループへOpenShiftの全ノードを設定する 
- 特権ユーザー権限を使用すること

## サンプルinventoryファイル

    # Openshift OSEv3 group
    [OSEv3:children]
    masters
    nodes

    # Openshift OSEv3 group vars
    [OSEv3:vars]
    # 特権ユーザー権限
    ansible_become=yes

    # Openshiftプロジェクト設定確認用変数
    openshift_prometheus_namespace: "openshift-metrics"
    openshift_logging_namespace: "logging"

    # alertmanager configmap 設定用変数
    ocp_prometheus_alert_repeat: "8h"
    ocp_fluentd_prometheus_port: "8085"
    ocp_fluentd_prometheus_protocol: "tcp"
    ocp_fluentd_proemtheus_service: "logging-fluentd"


    # Openshift master node ホスト設定
    [masters]
    ocp-master0[1:3].acom.local

    # Openshift node ホスト設定
    [nodes]
    ocp-master0[1:3].acom.local
    ocp-worker0[1:3].acom.local
    ocp-infra0[1:3].acom.local

## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ocp_prometheus playbooks/ocp-prometheus/site.yml
