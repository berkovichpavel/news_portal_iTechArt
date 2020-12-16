class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.where(params.keys.first => params[params.keys.first].to_sym) if params.keys.count > 2
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        # NewUserEmailMailer.notify_user(@user).deliver_now
        # NewUserEmailMailer.send_items_to_user('berkovich.pasha@gmail.com', [Item.first, Item.last]).deliver_now
        FindAllUsersJob.perform_now
        format.html { redirect_to user_path(params[:id]) }
      else
        format.html { render :edit }
      end
    end
  end

  def comments_activity
    @comments = @user.comments.page(params[:page]).per(10)
    @comments = if params[:body]
                  @comments.order(body: params[:body].to_sym)
                elsif params[:created_at]
                  @comments.order(created_at: params[:created_at].to_sym)
                else
                  @comments
               end
  end

  def items_activity
    # @items = @user.items.page(params[:page]).per(10)
    items_ids = ItemView.where(user_id: @user.id).pluck(:item_id)
    @items = Item.where(id: items_ids).page(params[:page]).per(10)
    @items = if params[:title]
               @items.order(title: params[:title].to_sym)
             elsif params[:created_at]
               @items.order(created_at: params[:created_at].to_sym)
             else
               @items
             end
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
