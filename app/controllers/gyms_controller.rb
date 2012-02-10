class GymsController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    @gyms = Gym.all
  end

  def show
    login_required
    @gym = Gym.find(params[:id])
  end

  def new
    login_required
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
    if @gym.save
      redirect_to @gym, :notice => "Successfully created gym."
    else
      render :action => 'new'
    end
  end

  def edit
    login_required
    @gym = Gym.find(params[:id])
  end

  def update
    @gym = Gym.find(params[:id])
    if @gym.update_attributes(params[:gym])
      redirect_to @gym, :notice  => "Successfully updated gym."
    else
      render :action => 'edit'
    end
  end

  def destroy
    login_required
    @gym = Gym.find(params[:id])
    @gym.destroy
    redirect_to gyms_url, :notice => "Successfully destroyed gym."
  end
end
