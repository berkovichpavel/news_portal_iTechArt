class RssSubscriptionsController < ApplicationController
  load_and_authorize_resource

  def new
    @rss_subscription = RssSubscription.new
    @categories = RssSubscription.categories
  end

  def index
    @rss_subscriptions = RssSubscription.all
  end

  def create
    @rss_subscription = RssSubscription.new(rss_subscription_params)
    if @rss_subscription.save
      CreateRssNewsJob.perform_later(@rss_subscription.reference_link, @rss_subscription.category)
      redirect_to rss_subscriptions_path
    else
      @categories = RssSubscription.categories
      render 'new'
    end
  end

  def destroy
    @rss_subscription.destroy
    redirect_to rss_subscriptions_path
  end

  private

  def rss_subscription_params
    params.require(:rss_subscription).permit(:reference_link, :category)
  end

end
