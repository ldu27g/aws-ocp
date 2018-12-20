# JBoss Fuseコンテナデプロイ用Playbook（ocp-fuse-eap）

## 参照ロール

- [ocp_fuse_eap](../../roles/ocp_fuse_eap/README.md)


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
    ocp_fuse_eap_present=false
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    fuse_eap_conf_dir=/tmp/fuse_on_eap
    # バイナリビルドに利用するバイナリ名
    fuse_eap_binary_name=ROOT.war
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリーム名
    fuse_eap_input_is_name=jboss-fuse70-eap-openshift
    # バイナリビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    fuse_eap_input_is_version=1.0
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    fuse_eap_image_import_repo=10.248.152.200:5000/fuse7/fuse-eap-openshift:1.0
    # バイナリビルドする際のビルド名
    fuse_eap_build_name=fuse-app

## 設定ファイル
 
- [ocp_fuse_eap](../../roles/ocp_fuse_eap/README.md)を参照し、必要に応じてfilesディレクトリにファイルを配置する

## Playbook実行コマンド

### JBoss Fuse コンテナのデプロイ
    ansible-playbook -i inventory/inventory_fuse_eap playbooks/ocp-fuse-eap/site.yml
