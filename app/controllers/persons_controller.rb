class PersonsController < ApplicationController
  def profile; end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: 'Ok'}
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
        :bio,
        :first_name,
        :last_name,
        :photo
    )
  end
end
