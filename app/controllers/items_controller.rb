class ItemsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:show, :index]
  before_action :tag_cloud, only: [:index, :show]

  def index
    @items =
      if params[:category]
        @items.where(category: params[:category])
      elsif params[:region]
        @items.where(region: params[:region])
      elsif params[:tag].present?
        @items.tagged_with(params[:tag])
      elsif params[:status]
        if current_user.redactor? || current_user.admin?
          @items.where(status: params[:status])
        else
          @items.where(status: params[:status], user_id: current_user.id)
        end
      elsif params[:commentable]
        binding.pry
        # @items.sort { |a, b| a.comments.where(user_id: User.where(role: 'user').ids).count <=> b.comments.where(user_id: User.where(role: 'user').ids).count }
        #{@items.joins(:comments).order('comments.count')}
      else
        @items
      end
    @important_items = @items.where(flag: true)
    @other_items = @items.where(flag: false).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @redactor = User.find(@item.user_id).email
    @user_review = current_user.reviews.where(item_id: @item.id).first if current_user
    @average_review = if @item.reviews.blank?
                        @has_review = false
                      else
                        @has_review = true
                        @item.reviews.average(:rating)
                      end
    @can_review = if current_user
                    current_user.reviews.where(item_id: @item.id).count < 1
                  else
                    false
                  end

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
    @item = current_user.items.new(item_params)
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
    permitted =
      [:title,
       :category,
       :short_description,
       :full_text,
       :mask,
       :region,
       :main_img_href,
       :flag,
       :tag_list]
    if can?(:change_status, Item)
      permitted << :status
    end
    params.require(:item).permit(*permitted)
  end
end
