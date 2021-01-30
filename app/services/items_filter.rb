class ItemsFilter < ApplicationService
  def initialize(items:, params:, user:)
    @items = items.where(status: 'active')
    @params = params
    @user = user
  end

  def call
    if @params[:category] then @items.where(category: @params[:category])
    elsif @params[:region] then @items.where(region: @params[:region])
    elsif @params[:tag].present? then @items.tagged_with(@params[:tag])
    elsif @params[:status]
      if @user.redactor? || @user.admin?
        @items.rewhere(status: @params[:status])
      else
        @items.rewhere(status: @params[:status], author_id: @user.id)
      end
    elsif @params[:commentable] then @items.joins(:comments).group(:id).select('items.*, COUNT(comments) as count_comments')
                                           .where(comments: { service_type: 'default' }).order('COUNT(comments) DESC')
    elsif @params[:readable] then @items.joins(:item_views).group(:id).order('COUNT(item_id) DESC')
    elsif @params[:rss] then @items.where(rss: true)
    # elsif @params[:query].present? @items.search(@params[:query])
    else @items
    end
  end
end
