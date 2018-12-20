# Openshift Elasticsearch 永続ボリューム設定用Playbook（ocp-elascticsearch）

## 参照ロール

- [ocp_elasticsearch](../../roles/ocp_elasticsearch/README.md)

## 前提条件

無し


## サンプルinventoryファイル

    [OSE:children]
    masters
    elasticsearch-nodes

    [OSE:vars]
    ansible_ssh_user=acom
    ansible_become=yes

    vars_ocp_elasticsearch_volume=[{"hostpath":"/data/elastic-vol", "mode":"0777", "owner":"root", "group":"root"}]
    vars_ocp_elasticsearch_nodeselector="logging-infra=elasticsearch"
    vars_ocp_elasticsearch_project="logging"
    vars_ocp_elasticsearch_sa_name="aggregated-logging-elasticsearch"
    vars_ocp_elasticsearch_sa_scc="privileged"

    [masters]
    ocp-master01.acom.local

    # Elasticsearch PODを配置するノード
    # このノードのローカルディスク上に永続領域(ディレクトリ)が作成される
    [elasticsearch-nodes]
    ocp-infra01.acom.local
    ocp-infra02.acom.local
    ocp-infra03.acom.local


## Playbook実行コマンド

### Elasticsearch PODの設定
    ansible-playbook -i inventory/inventory_elasticsearch playbooks/ocp-elasticsearch/site.yml
