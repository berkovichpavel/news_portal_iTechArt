class ApplicationController < ActionController::Base
  # def after_sign_in_path_for(resource)
  #   current_user_path
  # end
  #
  before_action :set_categories

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def set_categories
    @categories = Item.categories.keys
  end
end
