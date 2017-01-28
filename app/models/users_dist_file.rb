class UsersDistFile < ApplicationRecord
  belongs_to :user
  belongs_to :dist_file
end
