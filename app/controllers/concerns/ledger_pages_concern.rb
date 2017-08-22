module Concerns::LedgerPagesConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_ledger
    before_action :set_invites
  end

  protected

  def current_ledger_url(options = {})
    [ledger_url(@ledger), options[:hash]].compact.join('#')
  end

  def set_ledger
    @ledger = Ledger.find(params[:ledger_id])
  end

  def set_invites
    @invites = Subscription.where(email: current_user.email)
  end

  def ledger_manager
    @ledger_manager ||= LedgerManager.new(@ledger, current_user)
  end
end
