class ItemsController < ApplicationController
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
    @item.save

    redirect_to item_path(@item.id)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    redirect_to item_path(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :category, :short_description, :full_text, :mask, :region, :mask, :main_img_href, :flag)
  end
end
