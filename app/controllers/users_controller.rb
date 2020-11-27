class UsersController < ApplicationController
  load_and_authorize_resource

  def update
    respond_to do |format|
      if @user.update(user_params)
        binding.pry
        NewUserEmailMailer.notify_user(@user).deliver_now
        format.html { redirect_to user_path(params[:id]) }
      else
        format.html { render :edit }
      end
    end
  end


  private

  def user_params
    permitted = [:bio, :first_name, :last_name, :photo]
    if can?(:manage, User)
      permitted << :role
    end
    params.require(:user).permit(*permitted)
  end
end
