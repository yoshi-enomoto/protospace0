class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype, counter_cache: :likes_count
  # 『counter_cahce: :likes_count』はリレーションされているlikeの数の値をリレーション先のlikes_countというカラムの値に入れますの意味。
  # 従来、『counter_cache: true』を書くことで、『親モデル_count』名のカラムにカウント値が入る。
  # sumされる訳ではないので、場合によっては『counter_culture_fix_counts』を使う必要あり。
  # デッドロック発生の可能性や深い階層の場合、使用できない時もある。
  # likes_countカラムをbelong先のテーブルに追加。（親モデルに追加）
end
