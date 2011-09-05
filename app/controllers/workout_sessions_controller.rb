class WorkoutSessionsController < ApplicationController
  load_and_authorize_resource

  def index
    #@workout_sessions = WorkoutSession.all
    @workout_sessions = current_user.workout_sessions.all
  end
  
  def show
    @workout_session = WorkoutSession.find(params[:id])
  end
  
  def new
    @workout_session = WorkoutSession.new
    @workout_session.date = Date.parse(params[:date]).strftime("%m/%d/%Y") unless params[:date].blank?
    @workout_session.user_id = User.find(params[:user]).id unless params[:user].blank?
    @user = @workout_session.user unless @workout_session.user.blank?
#    1.times{@workout_session.exercise_sessions.build}
#    @workout_session.exercise_sessions.each do |exercise_session|
#      1.times{exercise_session.weight_sets.build}
#    end
    #@workouts = current_user.workouts.order(:name) unless current_user.workouts.blank?
    unless @user.workouts.blank?
      @workouts = @user.workouts.order(:name).collect{|w| w.name}.uniq
    else
      @workouts = []
    end
    #@exercises = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
    unless @user.exercises.blank?
      @exercise_names = @user.exercises.order(:name).collect{|e| e.name}.uniq unless @user.exercises.blank?
    else
      @exercise_names = []
    end
    #@exercises = current_user.exercises.order(:name) unless current_user.exercises.blank?
    @supplements = ["Creatine", "Protein", "Caffeine"]
    render :layout => 'box' # NEEDS TO BE SET AFTER EVERYTHING IS LOADED
  end
  
  def create
    @workout_session = WorkoutSession.new(params[:workout_session])
    date = @workout_session.date
    ### DO A PARTIAL CLONE IF ALREADY EXISTS ###
    if Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user.id) and !Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user.id).workout_sessions.last.blank?
      workout = Workout.find_by_name_and_user_id(params[:workout_session][:workout_name], @workout_session.user.id)
      @workout_session = workout.workout_sessions.last.clone
      @workout_session.date = date
      workout.workout_sessions.last.exercise_sessions.each_with_index do |exercise_session, index|
        @workout_session.exercise_sessions.build(:rest => exercise_session.rest, :tempo => exercise_session.tempo, :exercise_id => exercise_session.exercise_id)
        exercise_session.weight_sets.each do |weight_set|
          @workout_session.exercise_sessions[index].weight_sets.build(weight_set.attributes)
        end
      end
    ### ELSE JUST CREATE A NEW ONE ###
    else
      @workout_session.workout = Workout.create(:name => params[:workout_session][:workout_name], :user_id => @workout_session.user.id)
    end
#    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => params[:workout_session][:workout_name], :user_id => current_user.id)
    if @workout_session.save
      flash[:notice] = "Successfully created workout session for " + @workout_session.user.username + "."
      #redirect_to @workout_session
      redirect_to edit_workout_session_path(@workout_session)
      #redirect_to '/'
    else
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
  end
  
  def update
    @workout_session = WorkoutSession.find(params[:id])
    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => params[:workout_session][:workout_name], :user_id => @workout_session.user.id)
    if @workout_session.update_attributes(params[:workout_session])
      @workout_session.exercise_sessions.each do |exercise_session|
        exercise_session.save # NEED TO DO THIS SO THAT BEFORE_SAVE CALLBACK GETS CALLED
      end
      flash[:notice] = "Successfully updated workout session for " + @workout_session.user.username + "."
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
