require "jwt"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dist_files

  def get_token
    JWT.encode({user_id: self.id}, Rails.application.secrets.secret_key_base)
  end
end
