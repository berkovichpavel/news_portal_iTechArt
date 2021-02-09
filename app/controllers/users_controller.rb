class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = if params[:role]
               @users.where(role: params[:role]).includes([:photo_attachment]).order(created_at: :desc).page(params[:page]).per(12)
             else
               @users.includes([:photo_attachment]).order(created_at: :desc).page(params[:page]).per(12)
             end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  def comments_activity
    @comments = @user.comments.page(params[:page]).per(10)
    @comments = CommentsFilter.call(comments: @comments, params: params)
  end

  def items_activity
    items_ids = ItemView.where(user_id: @user.id).pluck(:item_id)
    @items = Item.where(id: items_ids).page(params[:page]).per(10)
    @items = UserItemsFilter.call(items: @items, params: params)
  end

  private

  def user_params
    params.require(:user).permit(:role) if can?(:manage, User)
  end
end
