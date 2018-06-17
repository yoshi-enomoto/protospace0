class CapturedImage < ActiveRecord::Base
  belongs_to :prototype

  validates :content,
            :status,
            presence: true

  # レコードに対して、カラムに数字を入れることで、そのレコードの種類を管理する設定
  # ステータス: main (メイン画像), sub (サブ画像)
  # 下記の場合、DBに渡される値は0,1,....となる。
  # 『enum status: {main: 10, sub: 20}』とすることで、DBに保存する値が設定可能
  enum status: %i(main sub)

  mount_uploader :content, PrototypeImageUploader
end
