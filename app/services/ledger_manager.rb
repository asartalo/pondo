class LedgerManager
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def createLedger(params = {})
    Ledger.create params.merge(owner: user)
  end

end
