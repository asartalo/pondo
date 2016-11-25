class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_user(@user)
    else
      auth_fail
    end
  end

  def failure
    redirect_to root_url
  end

  protected

  def sign_in_user(user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
    sign_in user
    redirect_to dashboard_url
  end

  def auth_fail
    session["devise.google_data"] = request.env["omniauth.auth"]
    failure
  end
end

