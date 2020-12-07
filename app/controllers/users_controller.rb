class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.where(params.keys.first => params[params.keys.first].to_sym) if params.keys.count > 2
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(params[:id]) }
      else
        format.html { render :edit }
      end
    end
  end

  def comments_activity
    @comments = @user.comments.page(params[:page]).per(10)
    @comments = @comments.order(params.keys.first => params[params.keys.first].to_sym) if params.keys.count > 3
  end

  def items_activity
    @items = @user.items.page(params[:page]).per(10)
    @items = @items.order(params.keys.first => params[params.keys.first].to_sym) if params.keys.count > 3
  end

  private

  def user_params
    permitted = [:bio, :first_name, :last_name, :photo, :hidden]
    if can?(:manage, User)
      permitted << :role
    end
    params.require(:user).permit(*permitted)
  end
end
