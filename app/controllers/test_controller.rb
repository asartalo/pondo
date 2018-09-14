class TestController < ApplicationController
  def ledger
    if (params[:email])
      user = User.find_by(email: params[:email])
      render json: Ledger.where(owner: user).last
    end
  end
end

