# JDSコンテナデプロイ用Playbook（ocp-jds）

## 参照ロール

- [ocp_jds](../../roles/ocp_jds/README.md)


## 前提条件

- バイナリビルドに利用するバイナリが参照可能であること

## サンプルinventoryファイル


    [ocp-master]
    ocp-master01.acom.local
     
    [ocp-master:vars]
    # OCコマンド実行のためのOpenShiftログインユーザ
    ocp_user=acom
    # OCコマンド実行のためのOpenShiftログインパスワード
    ocp_password=acom
    # コンテナ作成先となるプロジェクト名   
    project_name=jboss
    # コンテナをデプロイするときは「true」、アンデプロイするときは「false」を指定する
    ocp_jds_present=false
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    jds_conf_dir=/tmp/jds
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
    jds_input_is_name=decisionserver64-openshift
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    jds_input_is_version=1.0
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    jds_image_import_repo=10.248.152.200:5000/jboss-decisionserver-6/decisionserver64-openshift:1.3
    # バイナリビルドする際のビルド名
    jds_build_name=decisionserver-app

## 設定ファイル
 
- [ocp_jds](../../roles/ocp_jds/README.md)を参照し、必要に応じてfilesディレクトリにファイルを配置する

## Playbook実行コマンド

### JDS コンテナのデプロイ
    ansible-playbook -i inventory/inventory_jds playbooks/ocp-jds/site.yml
