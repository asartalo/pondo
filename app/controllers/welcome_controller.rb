class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    set_welcome_data
  end

  protected

  def set_welcome_data
    if current_user.has_viewable_ledgers?
      @no_ledger = false
      @ledger = current_user.viewable_ledgers.first
    else
      @no_ledger = true
    end
    @new_ledger = current_user.owned_ledgers.new(currency: current_user_currency)
  end

  def current_user_currency
    current_user.preferred_currency || location_currency
  end

  def location_currency
    IpToCurrency.make.get(request.remote_ip)
  end
end
