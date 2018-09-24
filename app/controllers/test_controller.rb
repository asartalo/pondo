require "pp"

class TestController < ApplicationController
  before_action :test_only

  def ledger
    if params[:email]
      user = User.find_by(email: params[:email])
      render json: Ledger.where(owner: user).last
    end
  end

  def run
    puts "\n============================================="
    print_script_or_code
    code = params[:code] || read_file(params.require(:script_name))
    render json: (pretty_error_wrap { Kernel.eval(code, binding()) })
  end

  private

  def pretty_error_wrap
    begin
      result = yield
      puts "\n"
    rescue Exception => e
      puts " ERROR!\nParams:"
      pp params.as_json
      raise e
    end
    result
  end

  def print_script_or_code
    print params[:script_name] ?
      "Run Script: #{params[:script_name].to_s}" :
      "Run Code: #{params[:code]}"
  end

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

