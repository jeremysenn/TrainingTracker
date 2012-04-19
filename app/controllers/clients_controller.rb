class ClientsController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    #@clients = Client.all
#    @clients = current_user.clients.all.sort_by(&:first_name)#.paginate(:page => params[:page], :per_page => 30)
    if current_user.is_trainer? and !current_user.trainer.clients.empty?
      @clients = current_user.trainer.clients.order(:first_name)
    elsif current_user.is_gym? and !current_user.gym.clients.empty?
      @clients = current_user.gym.clients.order(:first_name)
    end
  end

  def show
    login_required
    @user = current_user
    @client = Client.find(params[:id])
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @workout_session = WorkoutSession.new
    @workout_sessions = []
    @workout_sessions = @workout_sessions + @client.workout_sessions unless @client.blank?
    @bodycomps = @client.bodycomps
    unless @user.workouts.blank?
      @workouts = @user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end

    ### GET A COUNT JUST IN CASE ENTRIES ARE NEVER MADE, SO DON'T WANT TO SHOW GRAPH ###
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

  def new
    login_required
    unless current_user.subscription.blank?
      plan = current_user.subscription.plan
    else
      plan = Plan.find_by_name("Gold")
    end
    case plan.name
    when "Trial"
      unless current_user.trainer.clients.count >= 3
        @client = Client.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, Silver, or Bronze to add more clients."
      end
    when "Bronze"
      unless current_user.trainer.clients.count >= 10
        @client = Client.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, or Silver to add more clients."
      end
    when "Silver"
      unless current_user.trainer.clients.count >= 30
        @client = Client.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, or Silver to add more clients."
      end
    when "Gold"
      @client = Client.new
    else
      @client = Client.new
#      redirect_to plans_path, :notice => "Upgrade to Gold, Silver, or Bronze to add more clients."
    end
    
  end

  def create
    @client = Client.new(params[:client])
    existing_client = Client.find_by_email(@client.email) unless @client.email.blank?
    unless existing_client.blank?
      existing_client.trainer = @client.trainer
      @client = existing_client
    end
    if @client.save
      ### CHECK TO SEE IF THERE IS A USER IN THE SYSTEM WITH THIS CLIENT'S EMAIL TO CONNECT THE TWO ###
#      user_account = User.find_by_email(@client.email)
#      unless user_account.blank?
#        user_account.client_training_id = @client.id
#        user_account.is_client = true
#      end
#      user_account.save unless user_account.blank?
      redirect_to @client, :notice => "Successfully created client."
    else
      render :action => 'new'
    end
  end

  def edit
    login_required
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    ### CHECK TO SEE IF THERE IS A USER IN THE SYSTEM WITH THIS CLIENT'S EMAIL TO CONNECT THE TWO ###
#    user_account = User.find_by_email(@client.email)
#    unless user_account.blank?
#      user_account.client_training_id = @client.id
#      user_account.is_client = true
#    end
    
    if @client.update_attributes(params[:client])
#      user_account.save unless user_account.blank?
      redirect_to client_path(@client) + "#clientinformation_tab", :notice  => "Successfully updated client."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, :notice => "Successfully destroyed client."
  end

  def bodycomp_graphs
    @client = Client.find(params[:id])

    ### GET A COUNT JUST IN CASE ENTRIES ARE NEVER MADE, SO DON'T WANT TO SHOW GRAPH ###
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

  def assessment
    login_required
    @user = current_user
    @client = Client.find(params[:id])
    #@bodycomp = @client.bodycomps.last
    @bodycomp = Bodycomp.find(params[:bodycomp])
  end
end
