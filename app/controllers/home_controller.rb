class HomeController < ApplicationController
  def index
    login_required
    if params[:user].blank?
      @user = current_user
    else
      @user = User.find_by_username(params[:user])
#      flash[:notice] = "Currently viewing " + @user.username + "'s calendar"
    end

    ### GET A SUBSCRIPTION ###
    unless mobile_device?
      if (@user and @user.is_gym? and @user.subscription.blank?) or (@user and @user.is_trainer? and @user.subscription.blank?)
        redirect_to plans_path
      end
    end
    ###
    
    @workout_session = WorkoutSession.new
    @users = User.all
    #@date = Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    unless @user.blank?
      unless @user.client.blank?
        @client = @user.client
      else
        @client = Client.find(@user.client_training_id) unless @user.client_training_id.blank?
      end
      if @user.is_gym
        @clients = @user.gym.clients.all.sort_by(&:first_name)
        @trainers = @user.gym.trainers
      elsif @user.is_trainer
        @clients = @user.trainer.clients.all.sort_by(&:first_name)
      else
        @clients = []
      end
#      @clients = current_user.clients.all.sort_by(&:first_name)#.paginate(:page => params[:page], :per_page => 30)
      @exercises = current_user.exercises.all.sort_by(&:name)#.paginate(:page => params[:page], :per_page => 30)
      if @user.is_gym
#        @bodycomps = @user.gym.bodycomps.all.sort_by(&:first_name)
        @bodycomps = []
      elsif @user.is_trainer
        @bodycomps = @user.trainer.bodycomps
      else
        @bodycomps = []
      end
#      @bodycomps = current_user.bodycomps
      @workout_sessions = []
      if @user.is_trainer?
        @workout_sessions = @workout_sessions + @user.workout_sessions
#        @workout_sessions = @workout_sessions + @client.workout_sessions unless @client.blank?
      elsif @user.is_client?
        @workout_sessions = @workout_sessions + @client.workout_sessions unless @client.blank?
      end
#      @bodycomps = @user.bodycomps
      @foodlogs = @client.foodlogs unless @client.blank?
      unless @user.workouts.blank?
        @workouts = @user.workouts.order(:name).collect{|w| w.name}.uniq
      else
        @workouts = []
      end
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
    @neck_count = 0
    @shoulder_count = 0
    @chest_count = 0
    @arm_count = 0
    @waist_count = 0
    @hip_count = 0
    @thigh_count = 0
    @gastroc_count = 0
    @waist_hip_ratio_count = 0

    ### SET THESE IF THIS IS A TRAINING CLIENT USER WITH GRAPHS ON INDEX PAGE ###
    unless @user.blank? or !@user.is_client
      @client.bodycomps.each do |bodycomp|
        @chin_count = @chin_count + 1 unless bodycomp.chin.zero?
      @cheek_count = @cheek_count + 1 unless bodycomp.cheek.zero?
      @pec_count = @pec_count + 1 unless bodycomp.pec.zero?
      @tri_count = @tri_count + 1 unless bodycomp.tri.zero?
      @subscap_count = @subscap_count + 1 unless bodycomp.subscap.zero?
      @suprailiac_count = @suprailiac_count + 1 unless bodycomp.suprailiac.zero?
      @midaxil_count = @midaxil_count + 1 unless bodycomp.midaxil.zero?
      @umbilical_count = @umbilical_count + 1 unless bodycomp.umbilical.zero?
      @knee_count = @knee_count + 1 unless bodycomp.knee.zero?
      @calf_count = @calf_count + 1 unless bodycomp.calf.zero?
      @quad_count = @quad_count + 1 unless bodycomp.quad.zero?
      @ham_count = @ham_count + 1 unless bodycomp.ham.zero?
      @neck_count = @neck_count + 1 unless bodycomp.neck.zero?
      @shoulder_count = @shoulder_count + 1 unless bodycomp.shoulder.zero?
      @chest_count = @chest_count + 1 unless bodycomp.chest.zero?
      @arm_count = @arm_count + 1 unless bodycomp.arm.zero?
      @waist_count = @waist_count + 1 unless bodycomp.waist.zero?
      @hip_count = @hip_count + 1 unless bodycomp.hip.zero?
      @thigh_count = @thigh_count + 1 unless bodycomp.thigh.zero?
      @gastroc_count = @gastroc_count + 1 unless bodycomp.gastroc.zero?
      @waist_hip_ratio_count = @waist_hip_ratio_count + 1 unless bodycomp.waist.zero? or bodycomp.hip.zero?
      end
    end
  end

end
