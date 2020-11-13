class UsersController < ApplicationController
  # load_and_authorize_resource

  def profile; end

  # def index
  # end
  #
  # def show
  #   @user = User.find(params[:id])
  # end
  #
  # def edit
  #   @user = User.find(params[:id])
  # end
  #
  # def update
  #   @user = User.find(params[:id])
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to user_path(params[:id]) }
  #     else
  #       format.html { render :edit }
  #     end
  #   end
  # end
  #
  # private
  #
  # def user_params
  #   params.require(:user).permit(
  #     :bio,
  #     :first_name,
  #     :last_name,
  #     :photo
  #   )
  # end
end
