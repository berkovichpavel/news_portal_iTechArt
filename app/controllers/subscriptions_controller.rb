class SubscriptionsController < ApplicationController
  before_action :find_user
  before_action :find_subscription, only: [:edit, :update, :destroy]
  before_action :tag_cloud, only: [:new, :edit, :create, :update]
  before_action :set_sending_frequencies, only: [:edit, :new, :create, :update]
  before_action :set_regions, only: [:edit, :new, :create, :update]

  def new
    @subscription = Subscription.new
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
      render 'new'
    end
  end

  def edit
    @sending_frequencies = Subscription.sending_frequencies
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @subscription.destroy
    redirect_to user_path(@user)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:dispatch_hour, :sending_frequency, tags: [], categories: [], regions: [])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end

  def tag_cloud
    @tags = Item.tag_counts_on(:tags)
  end

  def set_sending_frequencies
    @sending_frequencies = Subscription.sending_frequencies
  end

  def set_regions
    @all_regions = Item.select('region').pluck(:region).uniq.reject(&:blank?)
  end
end
