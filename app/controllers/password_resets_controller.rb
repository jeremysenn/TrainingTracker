class PasswordResetsController < ApplicationController
  layout 'application'
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      flash[:notice] = "Email sent with password reset instructions."
    else
      flash[:notice] = "That email is not in our system."
    end
    redirect_to '/login'
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:alert] = "Password &crarr; reset has expired."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params[:user])
      flash[:notice] = "Password has been reset."
      redirect_to '/login'
    else
      render :edit
    end
  end



end
