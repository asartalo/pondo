class MainPagesController < ApplicationController
  before_action :authenticate_user!
  helper_method :new_ledger

  protected

  def new_ledger
    @new_ledger ||= current_user.owned_ledgers.new(currency: current_user_currency)
  end

  def current_user_currency
    current_user.preferred_currency || location_currency
  end

  private

  def location_currency
    IpToCurrency.make.get(request.remote_ip)
  end
end

