class MainPagesController < ApplicationController
  attr_reader :new_ledger

  before_action :authenticate_user!
  before_action :prepare_new_ledger

  helper_method :new_ledger

  protected

  def prepare_new_ledger
    @new_ledger = current_user.owned_ledgers.new(currency: current_user_currency)
  end

  def current_user_currency
    current_user.preferred_currency || location_currency
  end

  private

  def location_currency
    IpToCurrency.make.get(request.remote_ip)
  end
end

