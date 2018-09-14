class TestController < ApplicationController
  def ledger
    if (params[:email])
      user = User.find_by(email: params[:email])
      render json: Ledger.where(owner: user).last
    end
  end

  def run
    puts "Running code:", params[:code]
    result = Kernel.eval(params[:code])
    render json: result
  end
end

