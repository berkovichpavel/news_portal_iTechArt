class CommentsFilter < ApplicationService
  def initialize(comments:, params:)
    @comments = comments
    @params = params
  end

  def call
    if @params[:body]
      @comments.order(body: @params[:body].to_sym)
    elsif @params[:created_at]
      @comments.order(created_at: @params[:created_at].to_sym)
    else
      @comments
    end
  end
end
