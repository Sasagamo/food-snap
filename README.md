## アプリケーション名

FoodSnap

## アプリケーション概要

料理店の写真を記録し、レビューや評価を共有できるSNSアプリケーションです。料理やお店の写真を投稿し、独自の評価基準を設定して記録することができます。友人と感想を共有し、次の食事選びに役立てることが可能です。

## URL

[https://food-snap.onrender.com](https://food-snap.onrender.com) 

## テスト用アカウント
※現在ユーザーの退会機能は実装されていません、必要であれば以下のアカウントをお使いください。
- メール：test@example.com
- パスワード：test00

## 利用方法

### 投稿作成

1. トップページの「新規登録」ボタンをクリックしてユーザー登録を行います。

2. ログイン後、「新規投稿」ボタンをクリックし、投稿フォームにお店の情報、お店の評価、写真の選択を入力して「投稿する」を押すと、投稿が完了します。

※補足　評価項目を選択するには事前に【評価項目をカスタムする】から項目を作成する必要があります。

### 投稿閲覧

1. トップページやユーザー毎の「投稿一覧」から他のユーザーの投稿を閲覧出来ます。

2. 検索バーから投稿を絞り込むことが出来ます。

## 機能一覧

| 機能                   | ログインユーザー | 非ログインユーザー |
|------------------------|:----------------:|:------------------:|
| ユーザー登録           |        ○         |         ○          |
| ユーザー情報の編集     |        ○         |         ×          |
| 投稿の閲覧             |        ○         |         ○          |
| 投稿の作成・編集・削除 |        ○         |         ×          |
| 投稿の検索・絞り込み機能 |      ○         |         ○          |
| カスタム評価基準の設定 |        ○         |         ×          |

## アプリケーションを作成した背景

日常的に食事の写真を撮影・保存しているユーザーの中には、写真管理や友人との感想共有をしたいというニーズがあります。このアプリケーションでは写真と評価項目を結びつけ、記録と共有の場を提供し、ユーザーが次の食事選びに役立てることができるように設計しました。

## 実装予定の機能
- 投稿からマップでお店の詳細な位置を確認できる機能(googlemapsAPI)
- マップ上での位置情報管理と店舗検索(googlemapsAPI)
- カスタム評価基準に応じた並び替え機能
- ユーザー同士のフォロー/フォロワー機能
- ユーザーの退会

## 開発環境

- **フロントエンド**
  - HTML/CSS（Bootstrap非使用）
  
- **バックエンド**
  - Ruby on Rails

- **デプロイ**
  - Render

## 工夫した点

1. **UI/UXの最適化**  
   ページのアクセス権をログイン状態に応じて制御し、ユーザーが迷わず操作できるように配慮しました。また、評価項目のカスタマイズや投稿の絞り込み機能など、個人の好みに応じた使いやすいインターフェースを工夫しています。

2. **写真投稿機能**  
   投稿フォーム内で複数の画像を一度にアップロードでき、写真管理がしやすくなっています。

3. **入力必須情報の最小限定化**
   店の評価だけ設定したいユーザー、店の評価は無しで写真のアップロードだけしたいユーザーなど様々なニーズに答えるために、必須情報を店名・都道府県・食べ物ジャンルのみに限定しています。これによって気軽に投稿機能を利用できるようにユーザビリティの向上を図っています。










# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| account_name       | string  | null: false, unique: true |
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| bio                | text    |             |


### Association

- has_many :posts
- has_many :ratings
- has_many :followings, class_name: "Relationship", foreign_key: "follower"
- has_many :followers, class_name: "Relationship", foreign_key: "following"
- has_one_attached :avatar

## relationships テーブル　　※現在は未実装

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| following | references | null :false, foreign_key: true |
| follower  | references | null :false, foreign_key: true |

### Association

belongs_to :following, class_name:User
belongs_to :follower, class_name:User



## posts テーブル

| Column        | Type       | Options                  |
| ------------- | ---------- | ------------------------ |
| user          | references | null: false, foreign_key: true |
| store_name    | string     | null: false              |
| memo          | text       |                          |
| genre_id      | integer    | null: false (ActiveHash) |
| prefecture_id | integer    | null: false (ActiveHash) |


### Association

- belongs_to :user
- has_one :location, dependent:destroy
- has_many :post_ratings, dependent: destroy
- has_many :ratings, through: :post_ratings
- belongs_to_active_hash :genre
- belongs_to_active_hash :prefecture



## locations テーブル  ※現在は未実装

| Column    | Type       | Options |
| ----------| ---------- | ------- |
| post      | references | null: false, foreign_key: true |  
| latitude  | integer    |         |
| longitude | integer    |         |

### Association

- belongs_to :post


## post_ratings テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| post    | references | null: false, foreign_key: true |
| rating  | references | null: false, foreign_key: true |
| score   | integer    | null: false, default: 0 |

### Association

- belongs_to :post
- belongs_to :rating

## ratings テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | -------------------------------|
| rating_name | string     | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :posts, through: :post_ratings
- has_many :post_ratings, dependent: :destroy
