class WorkoutSessionsController < ApplicationController
  def index
    @workout_sessions = WorkoutSession.all
  end
  
  def show
    @workout_session = WorkoutSession.find(params[:id])
  end
  
  def new
    @workout_session = WorkoutSession.new
    @workout_session.date = Date.parse(params[:date]).strftime("%m/%d/%Y") if params[:date]
    1.times{@workout_session.exercise_sessions.build}
    @workout_session.exercise_sessions.each do |exercise_session|
      1.times{exercise_session.weight_sets.build}
    end
    #@workouts = current_user.workouts.order(:name) unless current_user.workouts.blank?
    @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq unless current_user.workouts.blank?
    #@exercises = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
    @exercise_names = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
    #@exercises = current_user.exercises.order(:name) unless current_user.exercises.blank?
    @supplements = ["Creatine", "Protein", "Caffeine"]
  end
  
  def create
    @workout_session = WorkoutSession.new(params[:workout_session])
    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => params[:workout_session][:workout_name], :user_id => current_user.id)
    if @workout_session.save
      flash[:notice] = "Successfully created workout session."
      redirect_to @workout_session
    else
      render :action => 'new'
    end
  end
  
  def edit
    @workout_session = WorkoutSession.find(params[:id])
    #@workout_session.date = @workout_session.date.strftime("%m/%d/%Y")
    @workouts = current_user.workouts.order(:name).collect{|w| w.name}.uniq unless current_user.workouts.blank?
    #@exercises = current_user.exercises.order(:name) unless current_user.exercises.blank?
    #@exercises = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
    @exercise_names = current_user.exercises.order(:name).collect{|e| e.name}.uniq unless current_user.exercises.blank?
  end
  
  def update
    @workout_session = WorkoutSession.find(params[:id])
    @workout_session.workout = Workout.find_or_create_by_name_and_user_id(:name => params[:workout_session][:workout_name], :user_id => current_user.id)
    if @workout_session.update_attributes(params[:workout_session])
      @workout_session.exercise_sessions.each do |exercise_session|
        exercise_session.save # NEED TO DO THIS SO THAT BEFORE_SAVE CALLBACK GETS CALLED
      end
      flash[:notice] = "Successfully updated workout session."
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
end
