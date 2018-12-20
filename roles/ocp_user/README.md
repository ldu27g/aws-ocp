# OpenShiftユーザー設定用ロール（ocp_user）

OpenShift環境にて、以下のユーザー設定を行う
- OpenShiftユーザー作成
- OpenShiftユーザー削除
- OpenShiftユーザーのパスワード設定・変更
- OpenShiftユーザーのロール設定（ローカル）
- OpenShiftユーザーのロール設定（クラスター）


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

- すべてのmasterサーバーを対象として実行すること

## 制約条件

無し

## 冪等性
無し<br>※ユーザー削除時にocコマンドによって毎回削除を実行するため

## 設定反映タイミング
タスク実行後

## 入力変数一覧

- パスワードファイル定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_user_path | 否 | any | char | /etc/origin/master/htpasswd | パスワードファイルの絶対パス

- OpenShiftユーザー・パスワード定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_user.username | 要 | any | char | - | ユーザー名
vars_ls_ocp_user.password | 要 | any | char | - | パスワード
vars_ls_ocp_user.state | 否 | present / absent | char | present | ユーザー 作成 or 削除

- ローカルロール定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_user.local_role.project | 要 | any | char | - | プロジェクト名
vars_ls_ocp_user.local_role.role | 要 | any | char | - | ローカルロール名

- クラスターロール定義変数

変数名 | 要否 | 選択肢 | 型 | デフォルト | 説明
:--- | :--- | :--- | :--- | :--- | :---
vars_ls_ocp_user.cluster_role.role | 要 | any | char | - | クラスターロール名


## 入力ファイル一覧

無し


## サンプル変数ファイル
    vars_ls_ocp_user_path: "/etc/origin/master/htpasswd"

    vars_ls_ocp_user:
      - username: "test1"
        password: "test1"
        state: "present"
        local_role:
          - project: "jboss"
            role: "admin"
          - project: "default"
            role: "view"
        cluster_role:
          - role: "cluster-admin"
          - role: "view"
      - username: "test2"
        password: "test3"
        state: "absent"
