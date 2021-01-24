module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
        session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

    # def google_oauth2
    #   user = User.from_google(from_google_params)
    #   if user.present?
    #     sign_out_all_scopes
    #     flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
    #     sign_in_and_redirect user, event: :authentication
    #   else
    #     flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
    #     redirect_to new_user_session_path
    #   end
    # end

    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url
      end
    end

    # def facebook
    #   respond_to do |format|
    #     format.html {
    #       @user = User.find_for_facebook(request.env["omniauth.auth"])
    #
    #       if @user.persisted?
    #         sign_in_and_redirect @user
    #         set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #       else
    #         session["devise.facebook_data"] = request.env["omniauth.auth"]
    #         redirect_to new_user_registration_url
    #       end
    #     }
    #   end
    # end

    def failure
      redirect_to root_path
    end
    #
    # def google_oauth2
    #     auth = request.env["omniauth.auth"]
    #     user = User.where(provider: auth["provider"], uid: auth["uid"])
    #             .first_or_initialize(email: auth["info"]["email"])
    #     user.name ||= auth["info"]["name"]
    #     user.save!
    #
    #     user.remember_me = true
    #     sign_in(:user, user)
    #
    #     redirect_to after_sign_in_path_for(user)
    #   end

  protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end

  private

    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email,
        avatar_url: auth.info.image
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
