class TrainersController < ApplicationController
  load_and_authorize_resource

  def index
#    @trainers = Trainer.all
    @trainers = current_user.gym.trainers
  end

  def show
    @trainer = Trainer.find(params[:id])
  end

  def new
    @trainer = Trainer.new
  end

  def create
    @trainer = Trainer.new(params[:trainer])
    if @trainer.save
      redirect_to @trainer, :notice => "Successfully created trainer."
    else
      render :action => 'new'
    end
  end

  def edit
    @trainer = Trainer.find(params[:id])
  end

  def update
    @trainer = Trainer.find(params[:id])
    if @trainer.update_attributes(params[:trainer])
      redirect_to @trainer, :notice  => "Successfully updated trainer."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @trainer = Trainer.find(params[:id])
    @trainer.destroy
    redirect_to trainers_url, :notice => "Successfully destroyed trainer."
  end
end
