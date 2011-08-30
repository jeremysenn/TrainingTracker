class UsersController < ApplicationController

  def index
    login_required
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @groups = Group.all.collect {|p| [ p.name, p.id ] }
    @groups.sort!
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    @groups = Group.all.collect {|p| [ p.name, p.id ] }
    @groups.sort!
    ### CHECK TO SEE IF THERE IS A CLIENT IN THE SYSTEM WITH THIS USERS'S EMAIL TO CONNECT THE TWO ###
    client_account = Client.find_by_email(@user.email)
    unless client_account.blank?
      @user.client_training_id = client_account.id
      @user.is_client = true
    end
    if @user.save
      session[:user_id] = @user.id
#      SupportMailer.new_account_notification(@user).deliver
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated your account."
    else
      render :action => 'edit'
    end
  end
end
