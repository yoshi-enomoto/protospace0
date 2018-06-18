class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many   :captured_images, dependent: :destroy

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
end
