class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: 'Comment'

  enum service_type: { 'default' => 'default', 'working' => 'working' }

  validates :body, presence: true

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  def destroy
    update(user: nil, body: '[deleted]')
  end

  def deleted?
    user.nil?
  end
end
