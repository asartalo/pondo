class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user.persisted?
      sign_in_user(user)
    else
      auth_fail
    end
  end

  def failure
    redirect_to root_url
  end

  protected

  def user
    @user ||= User.from_omniauth(request.env["omniauth.auth"])
  end

  def sign_in_user(user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
    sign_in user
    ledger = user.owned_ledgers.first
    if ledger
      redirect_to ledger_url(id: ledger.id)
    else
      redirect_to welcome_url
    end
  end

  def auth_fail
    session["devise.google_data"] = request.env["omniauth.auth"]
    failure
  end
end

