class HomeController < ApplicationController
  def index
    login_required
    if params[:user].blank?
      @user = current_user
    else
      @user = User.find_by_username(params[:user])
      flash[:notice] = "Currently viewing " + @user.username + "'s calendar"
    end
    @users = User.all
    #@date = Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    unless @user.blank?
      @client = Client.find(@user.client_training_id) unless @user.client_training_id.blank?
      @workout_sessions = []
      @workout_sessions = @workout_sessions + @user.workout_sessions
      @workout_sessions = @workout_sessions + @client.workout_sessions unless @client.blank?
      @biosignatures = @user.biosignatures
    end
  end

end
