# Linux OS設定（ロードバランサー）用Playbook<br>（ls-ocp-os-lb）

## 参照ロール
- [ls_ocp_os_lb](../../roles/ls_ocp_os_lb/README.md)

## 前提条件

無し


## サンプルinventoryファイル

    # ls_ocp_os_lbロールの変数を定義
    lb:
      hosts:
        "10.248.152.230":
      vars:
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        vars_ls_ocp_os_rpms:
          - "wget"
          - "net-tools"
          - "bind-utils"
          - "iptables-services"
          - "bridge-utils"
          - "bash-completion"
          - "kexec-tools"
          - "sos"
          - "psacct"
          - "NetworkManager"
          - "dnsmasq"
          - "git-1.8.3.1-11.el7.x86_64"
        vars_ls_ocp_os_journal_size: "10M"
        vars_ls_ocp_os_lb_localdomain: "acom.local"
        vars_ls_ocp_os_lb_subdomain: "dev-acom.local"
        vars_ls_ocp_os_lb_ipaddr: "10.248.152.219"
        vars_ls_ocp_os_lb_domain: "acom.local"
        vars_ls_ocp_os_lb_hosts:
          - ipaddr: "10.248.152.218"
            hostname: "ocp-lb01.acom.local ocp-lb01 lb-ocp-master.acom.local ocp-master.acom.local"
          - ipaddr: "10.248.152.221"
            hostname: "ocp-master01.acom.local ocp-master01"
          - ipaddr: "10.248.152.222"
            hostname: "ocp-master02.acom.local ocp-master02"

## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ls_ocp_os_lb playbooks/ls-ocp-os-lb/site.yml
