class DistFile < ApplicationRecord
  has_attached_file :attached
  validates_attachment :attached, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "text/plain"] }
  belongs_to :user
end
