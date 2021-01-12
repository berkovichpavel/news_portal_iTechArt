class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ip

  VALID_IP_ADDR =
    %w[232.160.172.227 237.76.103.70 42.140.33.228 235.114.82.169 215.60.99.250
       231.239.33.80 46.17.95.46 59.7.249.47 82.118.133.179 232.185.207.155
       191.174.235.58 218.200.3.234 33.80.91.183 255.202.4.137 166.51.16.240
       191.39.132.87 88.91.44.36 129.220.193.193 201.207.190.109 160.140.229.47
       111.63.248.243 243.200.6.103 215.143.171.200 133.115.141.169 48.204.171.235
       50.86.131.149 105.217.67.52 215.98.13.66 178.53.67.252 107.80.122.245
       254.88.7.253 109.24.67.126 249.20.136.98 159.79.115.233 76.4.19.157].freeze

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def set_categories
    @categories = Item.categories
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(_resource)
    session.delete(:return_to)
  end

  def set_ip
    session[:user_ip] ||= VALID_IP_ADDR.sample
  end

  def ip
    session[:user_ip]
  end
end
