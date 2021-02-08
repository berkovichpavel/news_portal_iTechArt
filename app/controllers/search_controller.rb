class SearchController < ApplicationController
  def search
    @items = if params[:query].nil?
               []
             else
               Item.text_search(params[:query]).includes(:reviews, :main_img_href_attachment).order(created_at: :desc).page(params[:page]).per(12)
             end
  end
end
