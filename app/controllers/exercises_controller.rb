class ExercisesController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    #@exercises = Exercise.all
    @exercises = current_user.exercises.all.sort_by(&:name).paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    login_required
    @exercise = Exercise.find(params[:id])
    @client = Client.find(params[:client]) unless params[:client].blank?
  end
  
  def new
    login_required
    @exercise = Exercise.new
    @exercise.videos.build
  end
  
  def create
    @exercise = Exercise.new(params[:exercise])
    if @exercise.save
      flash[:notice] = "Successfully created exercise."
      redirect_to @exercise
    else
      render :action => 'new'
    end
  end
  
  def edit
    login_required
    @exercise = Exercise.find(params[:id])
    @exercise.videos.build unless @exercise.videos.any?
  end
  
  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update_attributes(params[:exercise])
      flash[:notice] = "Successfully updated exercise."
      redirect_to @exercise
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    flash[:notice] = "Successfully destroyed exercise."
    redirect_to exercises_url
  end
end
