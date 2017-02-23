# arm_fsusb2_chinachu
arm+fsusb2の環境(raspberrypiなど)の環境でchinachuを動かすdockerfile

# 使い方メモ
- [https://github.com/Chinachu/docker-mirakurun-chinachu](https://github.com/Chinachu/docker-mirakurun-chinachu)をcloneしたあと,その中のmirakurunフォルダをこのリポジトリのファイルで上書きします
- mirakurunフォルダに[適当な何かの別館](http://d.hatena.ne.jp/katauna/searchdiary?word=%2A%5Brecfsusb2n%5D)から入手したrecfsusb2n_http_patch2.zipをコピーしておきます
- chinachuのDockerfileにあるFROMの部分をalpine:3.5からarm版のalpine(例えば,container4armhf/armhf-alpine)に変更します
- docker-composeの5353ポートの対応をコメントアウトするか別のポートに変更します(mDNSが有効になっている場合)
- その他,chinachuやmirakurunのコンフィグファイルを変更します
- あとはdocker-compose up -d
