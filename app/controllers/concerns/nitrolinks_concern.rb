module Concerns::NitrolinksConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_nitrolinks_location_header_from_session if respond_to?(:before_action)
  end

  def nitrolinks_request?
    request.headers.key? "nitrolinks-referrer"
  end

  def redirect_to(url = {}, options = {})
    super.tap do
      if nitrolinks_request?
        store_nitrolinks_location_in_session(location)
      end
    end
  end

  private

    def store_nitrolinks_location_in_session(location)
      session[:nitrolinks_location] = location if session
    end

    def set_nitrolinks_location_header_from_session
      # byebug if nitrolinks_request?
      if session && session[:nitrolinks_location]
        response.headers["Nitrolinks-Location"] = session.delete(:nitrolinks_location)
      end
    end
end
