class SubscriptionsController < ApplicationController
  before_action :find_user
  before_action :find_subscription, only: [:edit, :update, :destroy]

  def new
    @subscription = Subscription.new
    @sending_frequencies = Subscription.sending_frequencies
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.last_sent = Time.now
    @subscription.user_id = @user.id
    if @subscription.save
      @user.signed = true
      @user.save
      redirect_to user_path(@user)
    else
      @sending_frequencies = Subscription.sending_frequencies
      render 'new'
    end
  end

  def edit; end

  def update
    if @subscription.update(subscription_params)
      redirect_to user_path(@user)
    else
      @sending_frequencies = Subscription.sending_frequencies
      render 'edit'
    end
  end

  def destroy
    @subscription.destroy
    redirect_to user_path(@user)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:dispatch_hour, :sending_frequency)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end
end
