class NitrolinksController < ApplicationController
  layout 'nitrolinks'

  def index
  end

  def link1
  end

  def redirecting
    redirect_to action: 'redirected'
  end

  def redirected
  end
end

