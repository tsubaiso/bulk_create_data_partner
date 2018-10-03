# Bulk Create DataPartner
ツバイソSDK gem を利用した DataPartner 一括付与スクリプトです。([tsubaiso-sdk](https://github.com/tsubaiso/tsubaiso-sdk-ruby))
DataPartner については[API ドキュメント#外部連携機能](https://github.com/tsubaiso/tsubaiso-api-doumentation) を参照してください。


## 初期設定
ツバイソSDK gem のインストールが必要です。
下記の方法でインストールしてください。

    $ gem install tsubaiso-sdk

config.yml に base_url と access_token を記述します。

## 使い方
CSVファイルに "resource","object_id","data_partner - id_code","data_partner - link_url" を記述して、コマンドの引数にファイル名を指定します。

    $ ruby bulk_create_data_partner.rb sample.csv

## CSVファイル形式
Header code | Necessity | Description
--- | --- | --- | ---
`resource` | *required* | DataPartner を付与するオブジェクトの種類。[API ドキュメント](https://github.com/tsubaiso/tsubaiso-api-doumentation) のリソース名と同じです。
`id` | *required* | DataPartner を付与するオブジェクトのID.
`id_code` | *option* | 作成する DataPartner の id_code パラメータ。
`link_url` | *option* | 作成する DataPartner の link_url パラメータ。


