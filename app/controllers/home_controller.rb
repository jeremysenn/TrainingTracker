class HomeController < ApplicationController
  def index
    login_required
    if params[:user].blank?
      @user = current_user
    else
      @user = User.find_by_username(params[:user])
#      flash[:notice] = "Currently viewing " + @user.username + "'s calendar"
    end
    @users = User.all
    #@date = Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    unless @user.blank?
      @client = Client.find(@user.client_training_id) unless @user.client_training_id.blank?
      @clients = current_user.clients.all.sort_by(&:first_name)#.paginate(:page => params[:page], :per_page => 30)
      @exercises = current_user.exercises.all.sort_by(&:name).paginate(:page => params[:page], :per_page => 30)
      @biosignatures = current_user.biosignatures
      @workout_sessions = []
      @workout_sessions = @workout_sessions + @user.workout_sessions
      @workout_sessions = @workout_sessions + @client.workout_sessions unless @client.blank?
      @biosignatures = @user.biosignatures
      @foodlogs = @client.foodlogs unless @client.blank?
    end

    ### IF THIS IS A TRAINING CLIENT USER, GET A COUNT JUST IN CASE ENTRIES ARE NEVER MADE, SO DON'T WANT TO SHOW GRAPH ###
    @chin_count = 0
    @cheek_count = 0
    @pec_count = 0
    @tri_count = 0
    @subscap_count = 0
    @suprailiac_count = 0
    @midaxil_count = 0
    @umbilical_count = 0
    @knee_count = 0
    @calf_count = 0
    @quad_count = 0
    @ham_count = 0
    @waist_count = 0
    @hip_count = 0
    @waist_hip_ratio_count = 0

    ### SET THESE IF THIS IS A TRAINING CLIENT USER WITH GRAPHS ON INDEX PAGE ###
    unless @user.blank? or !@user.is_client
      @client.biosignatures.each do |biosignature|
        @chin_count = @chin_count + 1 unless biosignature.chin.zero?
        @cheek_count = @cheek_count + 1 unless biosignature.cheek.zero?
        @pec_count = @pec_count + 1 unless biosignature.pec.zero?
        @tri_count = @tri_count + 1 unless biosignature.tri.zero?
        @subscap_count = @subscap_count + 1 unless biosignature.subscap.zero?
        @suprailiac_count = @suprailiac_count + 1 unless biosignature.suprailiac.zero?
        @midaxil_count = @midaxil_count + 1 unless biosignature.midaxil.zero?
        @umbilical_count = @umbilical_count + 1 unless biosignature.umbilical.zero?
        @knee_count = @knee_count + 1 unless biosignature.knee.zero?
        @calf_count = @calf_count + 1 unless biosignature.calf.zero?
        @quad_count = @quad_count + 1 unless biosignature.quad.zero?
        @ham_count = @ham_count + 1 unless biosignature.ham.zero?
        @waist_count = @waist_count + 1 unless biosignature.waist.zero?
        @hip_count = @hip_count + 1 unless biosignature.hip.zero?
        @waist_hip_ratio_count = @waist_hip_ratio_count + 1 unless biosignature.waist.zero? or biosignature.hip.zero?
      end
    end
  end

end
