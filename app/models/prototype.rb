class Prototype < ActiveRecord::Base
  belongs_to :user

  validates :title,
            :catch_copy,
            :concept,
            presence: true
end
