class LedgerManager
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def createLedger
    Ledger.create owner: user
  end

end
