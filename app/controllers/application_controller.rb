class ApplicationController < ActionController::Base

  before_action :set_categories

  private

  def set_categories
    @categories = Item.categories.keys
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

end
