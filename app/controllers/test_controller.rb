class TestController < ApplicationController
  before_action :test_only

  def ledger
    if params[:email]
      user = User.find_by(email: params[:email])
      render json: Ledger.where(owner: user).last
    end
  end

  def run
    puts params[:script_name].to_s
    code = params[:code] || read_file(params.require(:script_name))
    puts "Running code:", code
    render json: Kernel.eval(code, binding())
  end

  private

  def read_file(file_name)
    File.read(
      File.join(
        Rails.root, 'spec', 'cypress', 'app_commands', "#{file_name}.rb"
      )
    )
  end

  def test_only
    redirect_to root_path unless Rails.env == 'test'
  end
end

