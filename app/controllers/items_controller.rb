class ItemsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items =
      if params[:category]
        Item.where(category: params[:category])
      else
        Item.all
      end
  end

  def show
    @item = Item.find(params[:id])
    @redactor = User.find(@item.user_id).email
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Item.categories.keys
    @access_mask = Item.access_masks.keys
  end

  def new
    @item = Item.new
    @categories = Item.categories.keys
    @access_mask = Item.access_masks.keys
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to item_path(@item.id)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    redirect_to item_path(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :category, :short_description, :full_text, :mask, :region, :mask, :main_img_href, :flag)
  end
end
