# protospace0

プロトタイプを投稿するアプリケーション

## 機能
- 投稿機能
- ユーザー登録機能
- 投稿に対するコメント機能
- いいね機能
- タグ付け機能

## 追加機能
- 未定

## 特記事項
- ローカル環境で実行する際、cloudinaryに関する記述の影響でエラーが生じるため、実行する際は下記３つを解除する。
  ・『gem "cloudinary"』を削除
  ・2つのimage_uploader.rbファイルについて、画像の保存先を『storage :file』のみにする、production、depelopment環境問わず。（7~11行目）
  ・

# Structure of DataBase

## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|avatar|text|-gem-|
|profile|text|-|
|position|string|-|
|occupation|string|-|

### association
```
has_many :prototypes
has_many :likes
has_many :comments
```


## Prototypesテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|catch_copy|string|null: false|
|concept|text|null: false|
|user|references|null: false, foreign_key: true|
|likes_count|integer|default: 0|

### association
```
has_many :captured_images
has_many :likes
has_many :comments
belongs_to :user
has_many :tags, through: :prototype_tags
has_many :prototype_tags, dependent: :destroy
```


## CapturedImagesテーブル
|Column|Type|Options|
|------|----|-------|
|content|string|-gem-|
|status|integer|-|
|prototype|references|null: false, foreign_key: true|

### association
```
belongs_to :prototype
```


## Likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|prototype|references|null: false, foreign_key: true|

### association
```
belongs_to :user
belongs_to :prototype
```


## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false |
|user|references|null: false, foreign_key: true|
|prototype|references|null: false, foreign_key: true|

### association
```
belongs_to :user
belongs_to :prototype
```


## Tagsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### association
```
has_many :prototypes, through: :prototype_tags
has_many :prototype_tags, dependent: :destroy
```


## PrototypeTagsテーブル
|Column|Type|Options|
|------|----|-------|
|prototype|references|null: false, foreign_key: true|
|tag|references|null: false, foreign_key: true|

### association
```
belongs_to :prototype
belongs_to :tag
```
