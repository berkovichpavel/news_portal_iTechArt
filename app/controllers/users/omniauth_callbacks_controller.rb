module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        binding.pry
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
