class Post < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :category

  def create_blurb 
    if !self.blurb && self.content
      self.blurb = self.content[0...140]
      self.save
    end
  end
end
