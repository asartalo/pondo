class ApplicationController < ActionController::Base
  include Concerns::NitrolinksConcern

  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  def ssl_configured?
    Rails.env.production?
  end

  def current_ledger
    current_user.current_ledger
  end
end
