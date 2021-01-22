class ItemsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:show, :index, :track]
  before_action :tag_cloud, only: [:index, :show]
  before_action :set_access_masks, only: [:edit, :new, :create, :update]
  before_action :set_statuses, only: [:edit, :new, :create, :update]

  TRACK_INTERVAL = 100

  def new; end

  def edit; end

  def index
    @items = ItemsFilter.call(items: @items, params: params, user: current_user)
    @important_items = @items.order(created_at: :desc).select(&:flag)
    @other_items = @items.where(flag: false).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    InsertItemViewsJob.perform_now(current_user&.id, @item.id, request.env['HTTP_USER_AGENT'], ip)
    @user_review = current_user.reviews.find_by(item_id: @item.id) if current_user
    @redactor = User.find(@item.author_id).nickname if @item.author_id
    @average_review = @item.reviews.average(:rating)
    @has_review = !!@average_review
  end

  def track
    view_track = current_user ? @item.item_views.find_by(user_id: current_user.id) : @item.item_views.find_by(user_ip: ip)
    view_track.increment!(:watching_time, TRACK_INTERVAL) if view_track.present?
    head :ok
  end

  def create
    @item = current_user.created_items.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      render 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render 'edit'
    end
  end

  def destroy
    @item.comments.destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    permitted = [:title, :category, :short_description, :full_text, :mask, :region, :main_img_href, :main_img, :flag, :tag_list]
    permitted << :status if can?(:change_status, Item)
    params.require(:item).permit(*permitted)
  end

  def tag_cloud
    @tags = Item.tag_counts_on(:tags)
  end

  def set_access_masks
    @access_mask = Item.masks
  end

  def set_statuses
    @statuses = Item.statuses
    @statuses_correspondent = { revision: 'revision', check: 'check' }
  end
end
