# OpenShiftユーザー設定用Playbook（ocp-user）

## 参照ロール

- [ocp_user](../../roles/ocp_user/README.md)

## 前提条件

- Playbookを実行する際は、inventoryにOpenShiftのmasterノードのみを設定する


## サンプルinventoryファイル

    # ocp_userロールの変数を定義
    # 以下のサンプルでは対象サーバーとユーザー変数を定義
    masters:
      hosts:
        ocp-master01:
        ocp-master02:
        ocp-master03:
      vars:
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        vars_ls_ocp_user_path: "/etc/origin/master/htpasswd"
        vars_ls_ocp_user:
          - username: "test1"
            password: "test1"
            state: "absent"
            local_role:
              - project: "jboss"
                role: "edit"
              - project: "default"
                role: "view"
            cluster_role:
              - role: "cluster-reader"
              - role: "view"
          - username: "test2"
            password: "test2"
            state: "present"
            local_role:
              - project: "jboss"
                role: "view"
              - project: "default"
                role: "admin"
            cluster_role:
              - role: "cluster-admin"
              - role: "edit"


## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ocp_user playbooks/ocp-user/site.yml
