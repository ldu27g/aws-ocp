# Nutanix VM 設定用ロール（nx_vm_clone）

Nutanix環境にて、仮想マシンの以下の設定を行う
- 仮想マシンのクローン作成
- 仮想マシンの削除

## Ansibleバージョン

2.4

## プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

## 実行時のサービス影響

実行条件 | サービス影響
:--- | :---
- | -

## タグ

タグ名 | 説明
:--- | :---
- | -

## 前提条件

- Prism APIのエンドポイントと通信が可能であること
 

## 制約条件

- PrismがNutanix API V2に対応していること


## 冪等性
有り

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- Nutanix API接続変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vm.vars.base_url | 要 | any | char | - | API URL
vm.vars.username | 要 | any | char | - | API接続ユーザー名
vm.vars.password | 要 | any | char | - | API接続パスワード

- Nutanix VM作成用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vm.vars.vars_nx_vm.name | 要 | any | char | - | 仮想マシン名
vm.vars.vars_nx_vm.vmid | 要 | any | char | - | クローン元仮想マシンのvmid
vm.vars.vars_nx_vm.vcpus | 要 | any | int | - | CPU数
vm.vars.vars_nx_vm.cores | 要 | any | int | - | CPUコア数
vm.vars.vars_nx_vm.memorymb | 要 | any | int | - | メモリサイズ[byte]
vm.vars.vars_nx_vm.ipaddr | 要 | any | char | - | IPアドレス(eth0)
vm.vars.vars_nx_vm.netmask | 要 | any | char | - | サブネットマスク
vm.vars.vars_nx_vm.network | 要 | any | char | - | ネットワーク
vm.vars.vars_nx_vm.gateway | 要 | any | char | - | デフォルトゲートウェイ
vm.vars.vars_nx_vm.power | 要 | on / off | char | - | 電源状態
vm.vars.vars_nx_vm.second_disk_byte | 否 | any | int | - | 2ndディスクサイズ[byte]
vm.vars.vars_nx_vm.third_disk_byte | 否 | any | int | - | 3rdディスクサイズ[byte]<br>※2ndディスクサイズ設定時のみ設定
vm.vars.vars_nx_vm.storage_container_name | 要 | any | char | - | ストレージコンテナ名

- Nutanix VM削除用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vm.vars.vars_nx_vm_delete | 要 | any | char | - | 仮想マシン名


## 入力ファイル一覧

無し


## サンプル変数ファイル
### Nutanix VM作成用

    vm:
      hosts: localhost
      ansible_connection: local
      vars:
        base_url: "https://10.248.152.190:9440/PrismGateway/services/rest/v2.0"
        username: "admin"
        password: "admin"
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
            storage_container_name: 'CONTAINER00'

### Nutanix VM削除用
    vm:
      hosts: localhost
      ansible_connection: local
      vars:
        base_url: "https://10.248.152.190:9440/PrismGateway/services/rest/v2.0"
        username: "admin"
        password: "admin"
        vars_nx_vm_delete:
          - "ocp-test01"
          - "ocp-test02"
