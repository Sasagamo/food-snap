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

## relationships テーブル

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



## locations テーブル

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
| rating_name | string     | null: false, 初期値として 美味しさ(id 1)、価格(id 2)、アクセス(id 3) を設定 |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :posts, through: :post_ratings
- has_many :post_ratings, dependent: :destroy