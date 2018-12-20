# LVMボリューム作成用ロール（ls_lvm）

Linux環境において、LVMボリュームの作成を行う。<br>
本ロールにて実施する処理内容は以下となる。
- 新規パーティションの作成
- LVM(PV/VG/LV)の作成(※VG/LVの拡張も可)
- 既存領域のデータコピー
- 自動マウントポイント設定(fstab登録)
-OS再起動

## Ansibleバージョン

2.4


## プラットフォーム

OS種別 | バージョン
:--- | :---
Linux  | CentOS7.3.1611
Linux　| Red Hat Enterprise Linux 7.4


## 実行時のサービス影響

実行条件 | サービス影響
:--- | :---
未設定時  | 影響なし
既設定時  | OS再起動


## タグ

タグ名 | 説明
:--- | :---
os_reboot | OSを再起動する

## 前提条件

- yumリポジトリと通信可能なこと。(「LVM2」パッケージがインストールされていない場合。)<br>
※本ロールでは、「LVM2」パッケージを使用してLVMボリュームの作成を行う。<br>
「LVM2」がインストールされていない場合は、本ロール内にてインストールを行う。
 

## 制約条件

- パーテョション作成は、未割当領域に対してのみ実施可能。<br>
※パーティションの再作成は行わない。
- パーテョション作成時は、すべての領域を1つのパーテョションとして作成する。<br>
※1つのデバイスに対して複数のパーテョションは作成できない。
- 本ロールでは、パーティションおよびLVMの縮小・削除は行えない。
- 既存ディレクトリ(/var,/home等)をマウントポイントとする場合、既存データを「cp」コマンドを使用して作成したLVM領域へコピーする。<br>
※「multi-user.target(ランレベル3以上)」でのデータコピーとなる。
- fstab登録内容の削除は行わないため、LVのマウントポイントを変更あるいは削除する場合、手動にて実施する必要がある。


## 冪等性

有り


## 設定反映タイミング

OS再起動後


## 入力変数一覧

- パーテョション作成用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト |  説明
:--- | :--- | :--- | :--- | :---  | :--- 
vars_ls_partition.devname | 要 | any | string | - | パーティション作成対象デバイス
vars_ls_partition.fstype | 要 | 8e / 83 | string | - | ファイルシステムID<br>8e : LVM<br>83 : ext4
vars_ls_partition.labeltype | 否 | msdos / gpt | string | msdos | パーテョションラベルタイプ
vars_ls_partition.parttype | 否 | primary / extended | string | primary | パーテョションタイプ<br>primary : 基本<br>extended : 拡張

- PV/VG作成用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト |  説明
:--- | :--- | :--- | :--- | :---  | :---
vars_ls_vg.vgname | 否 | any | string | - | ボリュームグループ(VG)名
vars_ls_vg.pesize | 否  | any | int | 4 |物理エクステンションサイズ(MB単位)
vars_ls_vg.pvname | 否：vgname未指定時<br> 要：vgname指定時 | any | string | - | VGに含める物理ボリューム名(PV)<br>※カンマ(,)区切りで複数指定可

- LV作成用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト |  説明
:--- | :--- | :--- | :--- | :---  | :---
vars_ls_lv.lvname | 否  | any | string | - | 論理ボリューム(LV)名
vars_ls_lv.vgname | 否：lvname未指定時<br> 要：lvname指定時 | any | string | - | LV作成元ボリュームグループ(VG)名
vars_ls_lv.lvsize | 否：lvname未指定時<br> 要：lvname指定時 | any | string | - | LVサイズ(B単位)<br>※1GBの場合：1G
vars_ls_lv.fstype | 否：vgname未指定時<br> 要：vgname指定時 | ext3 / ext4 | string | - | LVファイルシステムタイプ

- ボリュームマウント設定用変数

変数名 | 要否 | 選択肢 | 型 | デフォルト |  説明
:--- | :--- | :--- | :--- | :---  | :---
vars_ls_mount.devname | 否  | any | string | - | デバイスファイル名
vars_ls_mount.mpoint | 否：devname未指定時<br> 要：devname指定時 | any | string | - | マウントポイント
vars_ls_mount.fstype | 否：devname未指定時<br> 要：devname指定時 | ext3 / ext4 | string | - | ファイルシステムタイプ
vars_ls_mount.dump | 否 | any | string | '1' | ダンプフラグ
vars_ls_mount.passno | 否 | any | string | '0' | ファイルシステムチェック順序
vars_ls_mount.opts | 否 | any | string | 'defaults' | マウントオプション

## 入力ファイル一覧

無し


## サンプル変数ファイル

    vars_ls_partition:
      - devname: '/dev/xvdc'
        fstype: '8e'
        labeltype: 'msdos'
        parttype: 'primary'
      - devname: '/dev/xvdd'
        fstype: '8e'
        labeltype: 'msdos'
        parttype: 'primary'
        
    vars_ls_vg:
      - vgname: 'vg01'
        pesize: 16
        pvname: '/dev/xvdc1,/dev/xvdd1'
        
    vars_ls_lv:
      - vgname: 'vg01'
        lvname: 'lv01'
        lvsize: '15G'
        fstype: 'ext4'
      - vgname: 'vg01'
        lvname: 'lv02'
        lvsize: '20G'
        fstype: 'ext4'
        
    vars_ls_mount:
      - devname: '/dev/mapper/vg01-lv01'
        mpoint: '/var'
        fstype: 'ext4'
      - devname: '/dev/mapper/vg01-lv02'
        mpoint: '/data1'
        fstype: 'ext4'
        dump: '0'
        passno: '3'
        opts: 'ro'
