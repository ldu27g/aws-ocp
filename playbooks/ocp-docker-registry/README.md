# Openshift Docker Registry 永続ボリューム設定用Playbook（ocp-docker-registry）

## 参照ロール

- [ocp_docker_registry](../../roles/ocp_docker_registry/README.md)

## 前提条件

無し


## サンプルinventoryファイル

     [OSE:children]
     masters
     docker-registry-node

     [OSE:vars]
     ansible_ssh_user=acom
     ansible_become=yes
     
     vars_ocp_docker_registry_volume=[{"hostpath":"/data/docker-vol", "mode":"0777", "owner":"root", "group":"root"}]
     vars_ocp_docker_registry_node="ocp-infra01.acom.local"
     vars_ocp_docker_registry_nodeselector="docker-registry=present"
     vars_ocp_docker_registry_project="default"
     vars_ocp_docker_registry_sa_name="registry"
     vars_ocp_docker_registry_sa_scc="privileged"

     [masters]
     ocp-master01.acom.local

     # Docker Registry PODを配置するノード
     # このノードのローカルディスク上に永続領域(ディレクトリ)が作成される
     [docker-registry-node]
     ocp-infra01.acom.local


## Playbook実行コマンド

### Docker Registry PODの設定
    ansible-playbook -i inventory/inventory_docker_registry playbooks/ocp-docker-registry/site.yml
