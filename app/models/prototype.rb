class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many   :captured_images, dependent: :destroy
  has_many   :comments
  has_many   :likes, dependent: :destroy
  # 『dependent: :destroy』親モデルを削除した場合、関連する子モデルのレコードをどうする（削除する）かの設定。
  # 『through』を定義する場合、先に関連物を実施させる必要がある。
  has_many   :prototype_tags, dependent: :destroy
  has_many   :tags, through: :prototype_tags


  # 『protoytpe』にネストされた『captured_image』に対して投稿できるようにする。
  # ネストされているモデルを記載。キーではない。
  # コントローラー側には『captured_images_attributes: [:content]』でパラメータ許可する
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images
    #『reject_if:』を書くことで、保存が不要な場合は保存しない設定をする事が可能。
    # procとmethodのシンボルの２方法で指定可能。

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  #『prototypes』内のビューで使用するインスタンスメソッドをここに定義
  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
    # 『%b』は月の省略名
    # 『%d』は日にち
    # 『%a』は曜日の省略名
  end

  # タグ用の処理（引数では配列を渡している）
  def save_prototypes(saveprototype_tags)
    current_tag = self.tags.pluck(:name) unless self.tags.nil?
    # 『.pluck』は引数で与えたカラムの値で配列を取得する。
    # 『.nil?』は存在自体していない場合trueとなる。空が存在していればfalse。
    # 初回作成時はまっさらな空。（paramsの値が@prototypeに渡っていないから）
    # 逆に更新時は、前回作成した値を引き出す形となる。

    old_tags = current_tag - saveprototype_tags
    new_tags = saveprototype_tags - current_tag
    # この処理は、配列から配列を除外している。

    # Destroy old prototype_tags
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # Create new prototype_tags
    new_tags.each do |new_name|
      if new_name.present?
        prototype_tag = Tag.find_or_create_by(name: new_name)
        self.tags << prototype_tag
      end
    end
  end
end
