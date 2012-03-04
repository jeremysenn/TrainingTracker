class PasswordResetsController < ApplicationController
  layout 'application'
  
  def new
#    @user = User.new #to make the formatastic magic work
  end

#  def create
#    @user = User.find_by_email(params[:user][:email])
#    if @user
#      @user.deliver_password_reset_instructions!
#      render :action => :show_confirmation
#    else
#      flash[:notice] = "No user was found with that email address"
#      @user = User.new
#      render :action => :new
#    end
#  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:notice] = "Email sent with password reset instructions."
    redirect_to root_url
  end

  def edit
    #@user = User.new #to make the formatastic magic work
    @user = User.find_by_perishable_token(params[:id])
    
  end
  
  def update
    @user = User.find_by_perishable_token(params[:id])
    if @user
      @user.password = params[:user][:password]  
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.accepted_tos = true
      @user.is_active = true
      if @user.save  
        @user_session = UserSession.new(:login => @user.login, :password => params[:user][:password])
        flash[:notice] = "Password successfully updated"
        redirect_to root_url
      else  
        render :action => :edit  
      end
    else
      render :action => 'unknown'
    end
  end  

  private  
  
  def load_user_using_perishable_token  
    @user = User.find_using_perishable_token(params[:id])  
    unless @user  
      flash[:notice] = "We're sorry, but we could not locate your account. " +  
      "If you are having issues try copying and pasting the URL " +  
      "from your email into your browser or restarting the " +  
      "reset password process."  
      redirect_to root_url  
    end  
  end
end
