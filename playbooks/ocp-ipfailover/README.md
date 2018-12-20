# IP-failover PODデプロイ用Playbook（ocp-ipfailover）

## 参照ロール

- [ocp_ipfailover](../../roles/ocp_ipfailover/README.md)

## 前提条件

無し


## サンプルinventoryファイル

    [masters:var]
    vars_ocp_ipf_present="true"
    vars_ocp_ipf_project="default"
    vars_ocp_ipf_replicas="3"
    vars_ocp_ipf_nodeselector="region=infra"
    vars_ocp_ipf_port="80"
    vars_ocp_ipf_vips="10.248.152.218"
    vars_ocp_ipf_image="10.248.152.200:5000/openshift3/ose-keepalived-ipfailover:v3.9.30"

    [masters]
    ocp-master01.acom.local


## Playbook実行コマンド

### IPfailover PODのデプロイ
    ansible-playbook -i inventory/inventory_ipfailover playbooks/ocp-ipfailover/site.yml
