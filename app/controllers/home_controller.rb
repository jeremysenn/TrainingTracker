class HomeController < ApplicationController
  def index
    login_required
    if params[:user].blank?
      @user = current_user
    else
      @user = User.find_by_username(params[:user])
      flash[:notice] = "Currently viewing " + @user.username + "'s calendar"
    end
    if current_user.username == "J_Senn"
      flash[:notice] = "Hey Jordan - hope the workouts are going well. -Jer"
    end
    @users = User.all
    #@date = Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @workout_sessions = @user.workout_sessions unless @user.blank?
  end

end
