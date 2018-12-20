# Nutanix VM 設定用Playbook（ocp-nutanix）

## 参照ロール

- [nx_vm_clone](../../roles/nx_vm_clone/README.md)

## 前提条件

無し


## サンプルinventoryファイル

    vm:
      hosts: localhost
      vars:
        ansible_connection: local
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        base_url: "https://10.248.152.190:9440/PrismGateway/services/rest/v2.0"
        username: "admin"
        password: "Lenovo/4u"
        vars_nx_vm:
          - name: 'ocp-test01'
            vmid: '64c05b64-330c-400f-a4f7-869d569a9bdb'
            vcpus: 1
            cores: 2
            memorymb: 4096
            ipaddr: '10.248.152.230'
            netmask: '255.255.255.0'
            network: '10.248.152.0'
            gateway: '10.248.152.1'
            power: 'on'
            second_disk_byte: 21474836480
            storage_container_name: 'CONTAINER00'
          - name: 'ocp-test02'
            vmid: '64c05b64-330c-400f-a4f7-869d569a9bdb'
            vcpus: 1
            cores: 2
            memorymb: 4096
            ipaddr: '10.248.152.231'
            netmask: '255.255.255.0'
            network: '10.248.152.0'
            gateway: '10.248.152.1'
            power: 'on'
            second_disk_byte: 21474836480
            third_disk_byte: 21474836480
            storage_container_name: 'CONTAINER00'
            
    # 以下のサンプルではNutanix VM削除用の定義
    vm:
      hosts: localhost
      vars:
        ansible_connection: local
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        base_url: "https://10.248.152.190:9440/PrismGateway/services/rest/v2.0"
        username: "admin"
        password: "Lenovo/4u"
        vars_nx_vm_delete:
          - "ocp-test01"
          - "ocp-test02"


## Playbook実行コマンド

### Nutanix VM作成用
    ansible-playbook -i inventory/inventory_nx_vm_clone playbooks/ocp-nutanix/site.yml

### Nutanix VM削除用
    ansible-playbook -i inventory/inventory_nx_vm_delete playbooks/ocp-nutanix/site.yml
