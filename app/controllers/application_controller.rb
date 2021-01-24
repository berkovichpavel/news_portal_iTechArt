class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ip

  VALID_IP_ADDR =
    %w[103.59.90.183 151.53.79.20 24.170.245.209 119.223.97.240 56.160.106.175
       121.42.91.214 77.187.25.160 11.55.147.68 206.229.33.16 105.101.29.90
       90.34.37.163 181.93.156.27 5.183.111.213 91.117.249.215 21.241.104.150
       204.9.153.5 17.129.199.144 219.138.168.12 165.167.118.223 105.136.208.47
       219.170.40.47 212.208.116.205 52.103.50.118 97.171.151.2 220.250.151.18
       200.148.214.235 102.94.254.228 113.173.232.58 164.53.183.96 101.101.2.172].freeze

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :photo, :user_site, :instagram,
                                                              :github, :hidden, :nickname, :DOB, :address])
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
