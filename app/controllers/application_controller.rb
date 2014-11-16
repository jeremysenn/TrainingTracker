class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

#  check_authorization

#  before_filter :prepare_for_mobile

  rescue_from CanCan::AccessDenied do |exception|
#    redirect_to root_url, :alert => exception.message
    redirect_to root_url, :alert => "That's not a page you have access to"
  end

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  
  helper_method :mobile_device?

#  def prepare_for_mobile
#    session[:mobile_param] = params[:mobile] if params[:mobile]
#    request.format = :mobile if mobile_device?
#  end

end
