class CapturedImage < ActiveRecord::Base
  belongs_to :prototype

  validates :content,
            :status,
            presence: true

  mount_uploader :content, PrototypeImageUploader
end
