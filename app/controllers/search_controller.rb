class SearchController < ApplicationController
  def search
    @items = if params[:query].nil?
               []
             else
               Item.text_search(params[:query])
             end
  end
end
