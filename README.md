# リモートデスクトップ接続(RDS)に関するルール
## 目的
RDSを使用する人が増加してきました。そこで各自が快適にRDSを使えるようにする為のルールを制定する。

## ルール案
- 現行のルール(RDSを行うと、直接使用、RDS使用中にかかわらず権限が移動する)を継続する。
- Notionを用いた管理(実験室予約フォームと同様の感覚)　ページは分離する可能性もある。
- 直接使用、RDS使用中の人がいる場合は接続出来ない様にする。(<span style="color: red;">新システム</span>)

## 新システムの概要
Windowsの標準機能であるPowerShellを用いてPLASMAMED-DESK(共有PC)に対してコマンドを送信することで状況を把握し、接続可能かどうかを判断する。

## 新システムの特性、メリット
- 共有PCの状況を把握し、接続の判断を行う。
- 他人がRDSを使用している場合は接続が拒否され、使用者の名前が表示される。
- 直接共有PCを使用しているひとがいる場合はその旨が表示される。
- RDS接続中に他人からの接続および直接使用によって切断されることがない。<span style="color: red;">なお、直接使用の拒否についてはアカウントを分離することのみで対応可能です。</span>

## 新システムのデメリット
- PowerShellスクリプトを実行する為の環境構築が必要(複雑なので今年度は橋本が対応します。)
- スクリプトをダウンロードする必要がある。
- Windowsのセキュリティアップロードなどに対して対応の必要性が今後出てくる可能性がある。

## 新システムの導入方法　Windows
1. 必要なスクリプトの[ダウンロード ](https://github.com/plasma-med-ocu/RDS/archive/refs/heads/main.zip)\(rds.bat,rds.ps1)
2. スクリプトの実行許可 ps1ファイルのプロパティから変更 (場合によってはPowerShellの設定を変更する必要がある)
3. 資格情報の登録　コントロールパネルから資格情報を登録する　PC名:PLASMAMED-DESK　ユーザー名:PLASMA-remote　パスワードを入力
4. コマンド入力の為の環境構築\
Set-ExecutionPolicy RemoteSigned -Force\
winrm quickconfig -force\
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force\
5. rds.bat内のPathを各自の環境に合わせて調整
6. 実行確認

## 新システムの導入方法　Mac
1. PowerShellを[ダウンロード](https://learn.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.2)する。
2. 以降はWindowsと同様