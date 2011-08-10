class WorkoutsController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    #@workouts = Workout.all
    @workouts = current_user.workouts.all.sort_by(&:name).paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    login_required
    @workout = Workout.find(params[:id])
  end
  
  def new
    login_required
    @workout = Workout.new
  end
  
  def create
    @workout = Workout.new(params[:workout])
    if @workout.save
      flash[:notice] = "Successfully created workout."
      redirect_to @workout
    else
      render :action => 'new'
    end
  end
  
  def edit
    login_required
    @workout = Workout.find(params[:id])
    @user = current_user
  end
  
  def update
    @workout = Workout.find(params[:id])
    if @workout.update_attributes(params[:workout])
      flash[:notice] = "Successfully updated workout."
      redirect_to @workout
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    flash[:notice] = "Successfully destroyed workout."
    redirect_to workouts_url
  end
end
