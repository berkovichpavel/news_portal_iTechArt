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
    @categories = Item.categories.keys
    @item = Item.find(params[:id])
  end

  def new
    @categories = Item.categories.keys
  end

  def create
    @item = Item.new(item_params)
    @item.save

    redirect_to '/items/' + @item.id.to_s
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    redirect_to '/items/' + @item.id.to_s
  end

  private

  def item_params
    params.require(:item).permit(:title, :category, :short_description)
  end
end
