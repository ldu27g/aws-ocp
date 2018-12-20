# OpenShift Fluentd設定用Playbook（ocp-fluentd）

## 参照ロール

- [ocp_fluentd](http://10.248.152.169:8080/itone_shida_1/ocp-renovation/tree/release-3.9/roles/ocp_fluentd)

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
    openshift_logging_namespace="logging"
    openshift_prometheus_namespace="openshift-metrics"

    # logging-fluentd service 設定
    ocp_fluentd_prometheus_port="8085"
    ocp_fluentd_prometheus_protocol="tcp"
    ocp_fluentd_proemtheus_service="logging-fluentd"

    # Openshift master node ホスト設定
    [masters]
    ocp-master0[1:3].acom.local


## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ocp_fluentd playbooks/ocp-fluentd/site.yml
