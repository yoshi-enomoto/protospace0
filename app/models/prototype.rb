class Prototype < ActiveRecord::Base

  validates :title,
            :catch_copy,
            :concept,
            presence: true
end
