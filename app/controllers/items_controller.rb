class ItemsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:show, :index, :track]
  before_action :tag_cloud, only: [:index, :show]

  TRACK_INTERVAL = 100
  DEFAULT_IMAGE_SHOW = 'http://placehold.it/1000x500'.freeze
  DEFAULT_IMAGE_INDEX_SMALL = ''.freeze
  DEFAULT_IMAGE_INDEX_BIG = ''.freeze

  def index
    @items = if params[:category] then @items.where(category: params[:category])
             elsif params[:region] then @items.where(region: params[:region])
             elsif params[:tag].present? then @items.tagged_with(params[:tag])
             elsif params[:status]
               if current_user.redactor? || current_user.admin?
                 @items.where(status: params[:status])
               else
                 @items.where(status: params[:status], user_id: current_user.id)
               end
             elsif params[:commentable] then @items.joins(:comments).group(:id).select('items.*, COUNT(comments) as count_comments').where(comments: { service_type: 'default' }).order('COUNT(comments) DESC')
             elsif params[:readable] then @items.joins(:item_views).group(:id).order('COUNT(item_id) DESC')
             elsif params[:rss] then @items.where(rss: true)
             else @items
             end
    @important_items = @items.where(flag: true)
    @other_items = @items.where(flag: false).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    user_id = current_user ? current_user.id : nil
    request_env = request.env['HTTP_USER_AGENT']
    InsertItemViewsJob.perform_later(user_id, @item.id, request_env, ip)
    if current_user
      @can_review = current_user.reviews.where(item_id: @item.id).count < 1
      @user_review = current_user.reviews.where(item_id: @item.id).first
    end
    @main_image = if @item.main_img_href.attached?
                    url_for(@item.main_img_href)
                  elsif @item.main_img.empty?
                    DEFAULT_IMAGE_SHOW
                  else
                    @item.main_img
                  end
    @redactor = User.find(@item.author_id).email if @item.author_id
    @average_review = if @item.reviews.blank?
                        @has_review = false
                      else
                        @has_review = true
                        @item.reviews.average(:rating)
                      end
  end

  def track
    if current_user
      view_with_user = @item.item_views.find_by(user_id: current_user.id)
      view_with_user.increment!(:watching_time, TRACK_INTERVAL) if view_with_user.present?
    else
      view_without_user = @item.item_views.find_by(user_ip: ip)
      view_without_user.increment!(:watching_time, TRACK_INTERVAL) if view_without_user.present?
    end
    head :ok
  end

  def edit
    @statuses = Item.statuses
    @categories = Item.categories
    @access_masks = Item.masks
    @statuses_correspondent = { revision: 'revision', check: 'check' }
  end

  def new
    @item = Item.new
    @categories = Item.categories
    @access_masks = Item.masks
    @statuses = Item.statuses
    @statuses_correspondent = { revision: 'revision', check: 'check' }
  end

  def create
    @item = current_user.created_items.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      @access_mask = Item.masks.keys
      render 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      @access_mask = Item.masks.keys
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.comments.destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end

  def tag_cloud
    @tags = Item.tag_counts_on(:tags)
  end

  private

  def item_params
    permitted = [:title, :category, :short_description, :full_text, :mask, :region, :main_img_href, :main_img, :flag, :tag_list]
    permitted << :status if can?(:change_status, Item)
    params.require(:item).permit(*permitted)
  end
end
