# Tohle je paradni
module Authable

  extend ActiveSupport::Concern

  included do
    before_action :user_authentication
  end

  def user_authentication

    access_token = request.headers["HTTP_ACCESS_TOKEN"]

    if access_token == nil
      render json: {error_message: "No access token provided!", code: "ACCESS_DENIED"}, status: 401
      return
    end

    @user = User.find_by(access_token: access_token)
    if @user == nil
      render json: {error_message: "Invalid access token!", code: "ACCESS_DENIED"}, status: 401
      return
    end


  end

end
