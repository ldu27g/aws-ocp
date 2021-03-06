# Linux OS設定（ロードバランサー）用ロール（ls_ocp_os_lb）

Linux環境にて、以下のOS設定を行う
- ホスト名設定
- yumリポジトリ設定
- パッケージのインストール
- DNS設定
- chrony設定
- journalログサイズ設定
- hosts設定
- filewall停止設定 

## Ansibleバージョン

2.4

## プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.4

## 実行時のサービス影響

実行条件 | サービス影響
:--- | :---
DNS設定変更時 | NetworkManagerの再起動
chrony設定変更時 | chronyの再起動
journalログサイズ設定変更時 | journaldの再起動

## タグ

タグ名 | 説明
:--- | :---
- | -

## 前提条件

- yumリポジトリ設定で設定したリポジトリサーバーと構成対象サーバーが通信可能なこと
 

## 制約条件
無し

## 冪等性
無し<br>※yumリポジトリ設定において、実行する際に/etc/yum.repos.d配下のファイルを削除・再作成するため

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- ホスト名定義変数

 ホスト名定義変数として、ホスト名はinventoryファイルで定義されたホスト名を使用する

- rpm定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_os_rpms | 要 | any | char | - | インストールするパッケージ

- journalログサイズ定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_os_journal_size | 否 | any | char | - | journalログ最大サイズ<br>※サイズを含めた値を指定する(例：10M)<br>※「SystemMaxUse」の値

- DNS定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_os_lb_localdomain | 要 | any | char | - | ローカルドメイン名
vars_ls_ocp_os_lb_subdomain | 要 | any | char | - | サブドメイン名
vars_ls_ocp_os_lb_ipaddr | 要 | any | char | - | サブドメインのIPアドレス
vars_ls_ocp_os_lb_domain | 要 | any | char | - | 補完するドメイン名

- hosts定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_os_lb_hosts.ipaddr | 否 | any | char | - | IPアドレス
vars_ls_ocp_os_lb_hosts.hostname | 否 | any | char | - | ホスト名<br>※複数設定する場合は、スペース区切りで記入

## 入力ファイル一覧

ファイル名 | 要否 | 配置ディレクトリ | 説明
:--- | :--- | :--- | :---
Acom.repo | 要 | files/ | yumリポジトリ設定ファイル


## サンプル変数ファイル
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
