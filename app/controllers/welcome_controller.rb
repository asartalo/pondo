class WelcomeController < MainPagesController
  include Concerns::LedgerPagesConcern
  skip_before_action :set_ledger, only: [:index]

  def index
  end
end
