class ApplicationController < ActionController::Base

  include Authable
  protect_from_forgery with: :exception

end
