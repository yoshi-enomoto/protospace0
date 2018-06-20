class Tag < ActiveRecord::Base
  # 『through』を帝具する場合、先に関連物を実施させる必要がある。
  has_many   :prototype_tags, dependent: :destroy
  has_many   :prototypes, through: :prototype_tags
end
