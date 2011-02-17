class HomeController < ApplicationController
  def index
    login_required
    @user = current_user
    #@date = Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @workout_sessions = @user.workout_sessions unless @user.blank?
  end

end
