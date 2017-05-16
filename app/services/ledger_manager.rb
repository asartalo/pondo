class LedgerManager
  attr_reader :ledger, :user

  def initialize(ledger, user)
    @ledger = ledger
    @user = user
  end


end
