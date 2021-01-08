class StatisticsController < ApplicationController
  before_action :find_user

  def new
    @statistic = Statistic.new
  end

  def create
    @statistic = Statistic.new(statistic_params)
    if @statistic.save
      FindItemsToStatisticJob.perform_later(@user.id, @statistic.id)
      redirect_to user_path(@user)
    else
      @sending_frequencies = Subscription.sending_frequencies
      render 'new'
    end
  end


  private

  def statistic_params
    params.require(:statistic).permit(:begin_statistic, :end_statistic)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

end
