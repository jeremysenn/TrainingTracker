class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      logger.debug "session create - user_id: #{session[:user_id]}"
      flash[:notice] = "Logged in successfully."
      redirect_to root_path
#      redirect_to_target_or_default(root_path)
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    x
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to "/"
  end
end
