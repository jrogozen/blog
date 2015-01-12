class Post < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :category
  belongs_to :user
  has_many :comments

  def create_blurb 
    if !self.blurb && self.content
      self.blurb = self.content[0...140]
      self.save
    end
  end
end
