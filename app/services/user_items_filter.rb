class UserItemsFilter < ApplicationService
  def initialize(items:, params:)
    @items = items
    @params = params
  end

  def call
    if @params[:title]
      @items.order(title: @params[:title].to_sym)
    elsif @params[:created_at]
      @items.order(created_at: @params[:created_at].to_sym)
    else
      @items
    end
  end
end
