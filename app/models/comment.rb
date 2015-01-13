class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :post
  belongs_to :user

  def self.commentable?(data)
    errors = []
    errors << "Post does not exist" if !Post.find_by(id: data["post_id"])
    errors << "No content to add to comment" if !data["content"]
    return errors
  end
end
