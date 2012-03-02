class ExerciseSessionsController < ApplicationController
  load_and_authorize_resource

  def index
    #@exercise_sessions = ExerciseSession.all
    @exercise_sessions = []
    redirect_to '/'
  end
  
  def show
    @exercise_session = ExerciseSession.find(params[:id])
  end
  
  def new
    @exercise_session = ExerciseSession.new
  end
  
  def create
    @exercise_session = ExerciseSession.new(params[:exercise_session])
    if @exercise_session.save
      flash[:notice] = "Successfully created exercise session."
      unless mobile_device?
        redirect_to @exercise_session
      else
        redirect_to workout_session_path(@exercise_session.workout_session)
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @exercise_session = ExerciseSession.find(params[:id])
    @weight_sets = @exercise_session.weight_sets
  end
  
  def update
    @exercise_session = ExerciseSession.find(params[:id])
    if @exercise_session.update_attributes(params[:exercise_session])
      flash[:notice] = "Successfully updated exercise session."
      unless mobile_device?
        redirect_to @exercise_session
      else
        redirect_to workout_session_path(@exercise_session.workout_session)
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @exercise_session = ExerciseSession.find(params[:id])
    @exercise_session.destroy
    flash[:notice] = "Successfully destroyed exercise session."
    redirect_to exercise_sessions_url
  end
end
