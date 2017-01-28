require "jwt"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_dist_files
  has_many :dist_files, through: "users_dist_files"
  attr_accessor :selected_dist_files

  def get_token
    JWT.encode(
      {
        user_id: self.id,
        available_files_by_id: self.dist_files.map(&:id)
      },
      Rails.application.secrets.secret_key_base
    )
  end

  before_save :update_selected_dist_files

  private

  def update_selected_dist_files
    if self.selected_dist_files
      UsersDistFile.where(user_id: self.id).destroy_all
      self.selected_dist_files.each do |selected_dist_file|
        UsersDistFile.create(user_id: self.id, dist_file_id: selected_dist_file)
      end
    end
  end
end
