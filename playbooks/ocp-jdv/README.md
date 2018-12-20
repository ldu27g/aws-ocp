# JDVコンテナデプロイ用Playbook（ocp-jdv）

## 参照ロール

- [ocp_jdv](../../roles/ocp_jdv/README.md)


## 前提条件

- S2Iビルドに利用するGitbukectリポジトリが参照可能であること

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
    ocp_jdv_present=true
    # 設定ファイルの保持先ディレクトリ（作業用の一時ディレクトリのため、処理が完了すると最後に削除される）
    jdv_conf_dir=/tmp/jdv
    # S2Iビルドに使用するソースコードリポジトリにアクセスするためのユーザ
    jdv_git_pull_user_name=itone_shida_1
    # S2Iビルドに使用するソースコードリポジトリアクセスユーザのパスワード
    jdv_git_pull_password=12qwaszx
    # S2Iビルドする際にインプットとなるベースイメージのイメージストリーム名
    jdv_input_is_name=jboss-datavirt64-openshift
    # S2Iビルドする際にインプットとなるベースイメージのイメージストリームバージョン
    jdv_input_is_version=1.0
    # S2Iビルド結果を保持するアウトプット先イメージストリーム名
    jdv_output_is_name=datavirt-app
    # S2Iビルドする際にインプットとなるベースイメージの参照先dockerイメージリポジトリURL
    jdv_image_import_repo=10.248.152.200:5000/jboss-datavirt-6/datavirt64-openshift:1.0
    # S2Iビルドおよびアプリケーション作成で利用するOpenShiftテンプレート名
    jdv_template_name=datavirt64-basic-s2i-acom
    # JDV PODのレプリカ数
    jdv_replica_size=3
    # JDVのアプリケーション名（ビルド名や各種オブジェクト名としても利用する）
    jdv_apl_name=datavirt-app
    # S2Iビルドする際のソースコードリポジトリURL
    jdv_src_repo_uri=http://10.248.152.169:8080/git/itone_shida_1/sample-jdv.git
    # S2Iビルドする際のソースコードリポジトリのブランチ名
    jdv_src_repo_branch=master
    # JDV PODのメモリ制限
    jdv_resource_limit_memory=1Gi
    # S2Iビルドした結果のイメージストリーム作成先となるプロジェクト名
    jdv_output_is_namespace=jboss
    # JDVのOpenShisftテンプレート内で利用している各種変数を変更したい場合に-p key=valueで指定する（-p key=valueのセットを複数指定可能）
    jdv_template_param=''

## 設定ファイル
 
- [ocp_jdv](../../roles/ocp_jdv/README.md)を参照し、必要に応じてfilesディレクトリにファイルを配置する

## Playbook実行コマンド

### JDV コンテナのデプロイ
    ansible-playbook -i inventory/inventory_jdv playbooks/ocp-jdv/site.yml
