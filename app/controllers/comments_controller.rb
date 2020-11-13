class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.create(comment_params)
    @comment.commenter = current_user.email
    @comment.save
    redirect_to item_path(@item)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
