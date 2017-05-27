class ApplicationController < ActionController::Base

  include Authable
  protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }

end
