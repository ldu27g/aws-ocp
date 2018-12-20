# Linux OS設定用Playbook（ls-ocp-os）

## 参照ロール
- [ls_ocp_os](../../roles/ls_ocp_os/README.md)
- [ls_lvm](../../roles/ls_lvm/README.md)

## 前提条件

無し


## サンプルinventoryファイル

    # ls_ocp_osロールの変数を定義
    # 以下のサンプルではすべてのホストに対して共通のOS設定を定義
    all:
      children:
        master:
        infra:
        worker:
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
          - "docker"
          - "atomic-openshift-utils"
          - "git-1.8.3.1-11.el7.x86_64"
        vars_ls_ocp_os_nameserver:
          - "10.248.152.218"
          - "10.248.152.219"
        vars_ls_ocp_os_dockerops: "--selinux-enabled --log-driver=json-file --log-opt max-size=1M --log-opt max-file=3 --signature-verification=false  --insecure-registry 172.30.0.0/16 --insecure-registry=10.248.152.200:5000"
        vars_ls_ocp_os_journal_size: "10M"    
        
    # ls_lvmロールの変数を定義
    # 以下のサンプルではグループ単位にてlvmの設定を定義
    master:
      hosts:
        "10.248.152.230":
      vars:
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        vars_ls_partition:
          - devname: "/dev/sdb"
            fstype: "8e"
            labeltype: "msdos"
            parttype: "primary"
        vars_ls_vg:
          - vgname: "vg01"
            pesize: 16
            pvname: "/dev/sdb1"
        vars_ls_lv:
          - vgname: "vg01"
            lvname: "lv01"
            lvsize: "15G"
            fstype: "ext4"
        vars_ls_mount:
          - devname: "/dev/mapper/vg01-lv01"
            mpoint: "/var"
            fstype: "ext4"
            
    infra:
      hosts:
        "10.248.152.231":
      vars:
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        vars_ls_partition:
          - devname: "/dev/sdb"
            fstype: "8e"
            labeltype: "msdos"
            parttype: "primary"
          - devname: "/dev/sdc"
            fstype: "83"
            labeltype: "msdos"
            parttype: "primary"
        vars_ls_vg:
          - vgname: "vg01"
            pesize: 16
            pvname: "/dev/sdb1,/dev/sdc1"
        vars_ls_lv:
          - vgname: "vg01"
            lvname: "lv01"
            lvsize: "15G"
            fstype: "ext4"
          - vgname: "vg01"
            lvname: "lv02"
            lvsize: "20G"
            fstype: "ext4"
        vars_ls_mount:
          - devname: "/dev/mapper/vg01-lv01"
            mpoint: "/var"
            fstype: "ext4"
          - devname: "/dev/mapper/vg01-lv02"
            mpoint: "/data"
            fstype: "ext4"
            
    worker:
      hosts:
        "10.248.152.231":
      vars:
        ansible_ssh_user: "acom"
        ansible_become: "yes"
        vars_ls_partition:
          - devname: "/dev/sdb"
            fstype: "8e"
            labeltype: "msdos"
            parttype: "primary"
          - devname: "/dev/sdc"
            fstype: "83"
            labeltype: "msdos"
            parttype: "primary"
        vars_ls_vg:
          - vgname: "vg01"
            pesize: 16
            pvname: "/dev/sdb1,/dev/sdc1"
        vars_ls_lv:
          - vgname: "vg01"
            lvname: "lv01"
            lvsize: "15G"
            fstype: "ext4"
          - vgname: "vg01"
            lvname: "lv02"
            lvsize: "20G"
            fstype: "ext4"
        vars_ls_mount:
          - devname: "/dev/mapper/vg01-lv01"
            mpoint: "/example01"
            fstype: "ext4"
          - devname: "/dev/mapper/vg01-lv02"
            mpoint: "/example02"
            fstype: "ext4"
            


## Playbook実行コマンド

    ansible-playbook -i inventory/inventory_ls_ocp_os playbooks/ls-ocp-os/site.yml
