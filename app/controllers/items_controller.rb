class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @categories = Category.all
    @item = Item.find(params[:id])
  end

  def new
    @categories = Category.all
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

  def category
    @category = Category.find_by(alias: params[:category])
    @items = @category.items
    render 'index'
  end

  private

  def item_params
    params.require(:item).permit(:title, :category, :short_description)
  end
end
