class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @first_time = current_user.has_viewable_ledgers?
    @ledger = current_user.owned_ledgers.new
  end
end
