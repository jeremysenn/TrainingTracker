class WorkoutSessionsController < ApplicationController
  load_and_authorize_resource

  def index
    #    @workout_sessions = WorkoutSession.all
    #    @workout_sessions = current_user.workout_sessions.all
    @client = Client.find(params[:client]) unless params[:client].blank?
    if current_user.is_trainer?
      @workout_sessions = current_user.workout_sessions.sort_by(&:date).reverse unless current_user.workout_sessions.empty?
    elsif current_user.is_client?
      @workout_sessions = current_user.client.workout_sessions.sort_by(&:date).reverse unless current_user.client.blank? or current_user.client.workout_sessions.empty?
    end
  end
  
  def show
    @workout_session = WorkoutSession.find(params[:id])
  end
  
  def new
    @workout_session = WorkoutSession.new
    @workout_session.date = Date.parse(params[:date]).strftime("%m/%d/%Y") unless params[:date].blank?
    unless params[:user].blank?
      @workout_session.user_id = User.find(params[:user]).id
    else
      @workout_session.user_id = current_user.id
    end
    @workout_session.client_id = Client.find(params[:client]).id unless params[:client].blank?
    @user = @workout_session.user unless @workout_session.user.blank?
#    if mobile_device?
#        1.times{@workout_session.exercise_sessions.build}
#        @workout_session.exercise_sessions.each do |exercise_session|
#        1.times{exercise_session.weight_sets.build}
#      end
#    end
#    1.times{@workout_session.exercise_sessions.build}
#    @workout_session.exercise_sessions.each do |exercise_session|
#      1.times{exercise_session.weight_sets.build}
#    end
#    @workouts = current_user.workouts.order(:name) unless current_user.workouts.blank?
#    unless @user.workouts.blank?
    unless current_user.workouts.blank?
      @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end
    #@exercises = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
#    unless @user.exercises.blank?
    unless current_user.exercises.blank?
      @exercise_names = current_user.exercises.order(:name).collect{|e| e.name}.uniq
    else
      @exercise_names = []
    end
    #@exercises = current_user.exercises.order(:name) unless current_user.exercises.blank?
    if current_user.is_trainer? and !current_user.trainer.clients.empty?
      @clients = current_user.trainer.clients.collect {|c| [ c.full_name, c.id ] }
    elsif current_user.is_gym? and !current_user.gym.clients.empty?
      @clients = current_user.gym.clients.collect {|c| [ c.full_name, c.id ] }
    end
    unless mobile_device?
      render :layout => 'box' # NEEDS TO BE SET AFTER EVERYTHING IS LOADED
    end
  end
  
  def create
    @workout_session = WorkoutSession.new(params[:workout_session])
    date = @workout_session.date
    client = @workout_session.client
    ### DO A PARTIAL CLONE IF ALREADY EXISTS ###
    if Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user_id) and !Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user_id).workout_sessions.last.blank?
      workout = Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user.id)
      @workout_session = workout.workout_sessions.last.clone
      @workout_session.date = date
      @workout_session.reminder_sent = false
      @workout_session.client = client unless client.blank?
      workout.workout_sessions.last.exercise_sessions.each_with_index do |exercise_session, index|
        @workout_session.exercise_sessions.build(:sets => exercise_session.sets, :rest => exercise_session.rest, :tempo => exercise_session.tempo, :exercise_id => exercise_session.exercise_id)
        exercise_session.weight_sets.each do |weight_set|
          @workout_session.exercise_sessions[index].weight_sets.build(weight_set.attributes)
        end
      end
    ### ELSE JUST CREATE A NEW ONE ###
    else
      unless params[:workout_session][:workout_name].blank?
        name = params[:workout_session][:workout_name]
      else
        unless date.blank?
          name = date.strftime("%m/%d/%Y") + " Workout"
        else
          name = "Workout Name"
        end
      end
      @workout_session.workout = Workout.create(:name => name, :user_id => @workout_session.user_id)
#      1.times{@workout_session.exercise_sessions.build}
#      @workout_session.exercise_sessions.each do |exercise_session|
#        1.times{exercise_session.weight_sets.build}
#      end
    end
#    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => params[:workout_session][:workout_name], :user_id => current_user.id)
    if @workout_session.save
      unless mobile_device?
        flash[:notice] = "Successfully created workout session"
        redirect_to edit_workout_session_path(@workout_session)
      else
        redirect_to @workout_session
      end
    else
      flash[:notice] = "Error creating workout session"
      render :action => 'new'
    end
  end
  
  def edit
    @workout_session = WorkoutSession.find(params[:id])
    #@workout_session.date = @workout_session.date.strftime("%m/%d/%Y")
    unless @workout_session.user.workouts.blank?
      @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end
    #@exercises = current_user.exercises.order(:name) unless current_user.exercises.blank?
    #@exercises = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
    unless @workout_session.user.exercises.blank?
      @exercise_names = @workout_session.user.exercises.order(:name).collect{|e| e.name}.uniq
    else
      @exercise_names = []
    end

    unless @workout_session.user.workouts.blank?
      @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end

    if current_user.is_trainer? and !current_user.trainer.clients.empty?
      @clients = current_user.trainer.clients.collect {|c| [ c.full_name, c.id ] }
    elsif current_user.is_gym? and !current_user.gym.clients.empty?
      @clients = current_user.gym.clients.collect {|c| [ c.full_name, c.id ] }
    end
  end
  
  def update
#    @workout_session = WorkoutSession.includes(:exercise_sessions).find(params[:id])
    @workout_session = WorkoutSession.find(params[:id])
    unless @workout_session.user.workouts.blank?
      @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end
    unless @workout_session.user.exercises.blank?
      @exercise_names = @workout_session.user.exercises.order(:name).collect{|e| e.name}.uniq
    else
      @exercise_names = []
    end
    unless params[:workout_session][:workout_name].blank?
      name = params[:workout_session][:workout_name]
    else
      name = @workout_session.date.strftime("%m/%d/%Y") + " Workout"
    end
    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => name, :user_id => @workout_session.user.id)
    if @workout_session.update_attributes(params[:workout_session])
      @workout_session.exercise_sessions.each do |exercise_session|
        exercise_session.save # NEED TO DO THIS SO THAT BEFORE_SAVE CALLBACK GETS CALLED
      end
      flash[:notice] = "Successfully updated workout session"
      redirect_to @workout_session
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @workout_session = WorkoutSession.find(params[:id])
    @workout_session.destroy
    flash[:notice] = "Successfully deleted workout session."
    redirect_to '/'
  end

  def quick_create

  end

end
