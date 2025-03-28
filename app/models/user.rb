# frozen_string_literal: true

class User < ActiveRecord::Base
  # UserモデルがDevise機能を使えるように（user.valid_password? など）
  extend Devise::Models
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :companies
end
