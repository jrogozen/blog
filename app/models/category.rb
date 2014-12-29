class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, case_sensitive: false
  has_many :posts
end
