class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
  end
  
  def show
    @exercise = Exercise.find(params[:id])
  end
  
  def new
    @exercise = Exercise.new
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
    @exercise = Exercise.find(params[:id])
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
