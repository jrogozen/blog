class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  has_many :posts
  has_many :comments
end
