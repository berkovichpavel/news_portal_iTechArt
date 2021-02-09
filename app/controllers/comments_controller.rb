class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.service_type = (current_user.role == 'user' ? 'default' : 'working')
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @commentable }
        format.js
      end
    else
      redirect_to @commentable, alert: 'Something went wrong'
    end
  end

  def destroy
    @commentable.comments.find(params[:id]).destroy
    redirect_to @commentable
    # render json: { success: true }
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
