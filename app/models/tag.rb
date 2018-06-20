class Tag < ActiveRecord::Base
  has_many   :prototypes, through: :prototype_tags
  has_many   :prototype_tags, dependent: :destroy
end
