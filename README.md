# Server Status with NodeJS

CS24構内GPUサーバー監視用ウエブアプリ

## 利用方法

ウエブブラウザーで[Insert local address  here]にアクセスする
可視化は共有サーバーに制限されているが…

## Server Info RESTAPI

監視したいサーバー上に起動し，そのサーバーの基本情報とGPUの利用状態をアクセス可能
にしている

### インスト-ル方法

## Central Monitoring WebApp

上述のServer Info RESTAPIがインストールされたサーバーの情報を周期的に収集し，
ウエブアプリの形でまとめている

### インストール方法

# Improvement (?)
- Optimize variables mgmt in central monitor app
- Collapse Storage Info
- Badge close to "Online" to signlal harddrive critical condition
- Slack Notification on full hard drives

# Credits
- NodeJS SystemInforation wrapper [insert link]
- Bootstrap Admin Dashboard template [insert link]
