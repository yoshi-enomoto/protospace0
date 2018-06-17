class CapturedImage < ActiveRecord::Base
  mount_uploader :content, PrototypeImageUploader
end
