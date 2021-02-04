class SearchController < ApplicationController
  def search
    @items = if params[:query].nil?
               []
             else
               Item.search(params[:query])
             end
  end
end
