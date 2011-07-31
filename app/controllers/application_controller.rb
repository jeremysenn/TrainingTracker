class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

#  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
#    redirect_to root_url, :alert => exception.message
    redirect_to root_url, :alert => "That's not a page you have access to"
  end

end
