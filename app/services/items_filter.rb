class ItemsFilter < ApplicationService
  def initialize(items:, params:)
    @items = items
    @params = params
  end

  def call
    if @params[:category] then @items.where(category: @params[:category])
    elsif @params[:region] then @items.where(region: @params[:region])
    elsif @params[:tag].present? then @items.tagged_with(@params[:tag])
    elsif @params[:status]
      if current_user.redactor? || current_user.admin?
        @items.where(status: @params[:status])
      else
        @items.where(status: @params[:status], author_id: current_user.id)
      end
    elsif @params[:commentable] then @items.joins(:comments).group(:id).select('items.*, COUNT(comments) as count_comments').where(comments: { service_type: 'default' }).order('COUNT(comments) DESC')
    elsif @params[:readable] then @items.joins(:item_views).group(:id).order('COUNT(item_id) DESC')
    elsif @params[:rss] then @items.where(rss: true)
    else @items
    end
  end
end
