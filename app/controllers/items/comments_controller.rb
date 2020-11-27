module Items
  class CommentsController < CommentsController
    before_action :set_commentable

    private

    def set_commentable
      @commentable = Item.find(params[:item_id])
    end
  end
end
