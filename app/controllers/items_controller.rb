class ItemsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:show, :index]
  before_action :tag_cloud

  def index
    @items =
      if params[:category]
        @items.where(category: params[:category])
      elsif params[:tag].present?
        @items.all.tagged_with(params[:tag])
      else
        @items
      end.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @redactor = User.find(@item.user_id).email
  end

  def edit
    @categories = Item.categories.keys
    @access_mask = Item.access_masks.keys
  end

  def new
    @item = Item.new
    @categories = Item.categories.keys
    @access_mask = Item.access_masks.keys
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      binding.pry
      @access_mask = Item.access_masks.keys
      render 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      @access_mask = Item.access_masks.keys
      render 'edit'
    end

  end

  def destroy
    @item = Item.find(params[:id])
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
    params.require(:item).permit(:title, :category, :short_description, :full_text, :mask, :region, :mask, :main_img_href, :flag, :tag_list)
  end
end
