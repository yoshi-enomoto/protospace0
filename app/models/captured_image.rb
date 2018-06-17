class CapturedImage < ActiveRecord::Base
  validates :content,
            :status,
            presence: true

  mount_uploader :content, PrototypeImageUploader
end
