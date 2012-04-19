class TrainersController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
#    @trainers = Trainer.all
    @trainers = current_user.gym.trainers
  end

  def show
    login_required
    @trainer = Trainer.find(params[:id])
  end

  def new
    login_required
    plan = current_user.subscription.plan
    case plan.name
    when "Trial"
      unless current_user.gym.trainers.count >= 1
        @trainer = Trainer.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, Silver, or Bronze to add more trainers."
      end
    when "Bronze"
      unless current_user.gym.trainers.count >= 10
        @trainer = Trainer.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, or Silver to add more trainers."
      end
    when "Silver"
      unless current_user.gym.trainers.count >= 30
        @trainer = Trainer.new
      else
        redirect_to plans_path, :notice => "Upgrade to Gold, or Silver to add more trainers."
      end
    when "Gold"
      @trainer = Trainer.new
    else
      redirect_to plans_path, :notice => "Upgrade to Gold, Silver, or Bronze to add more trainers."
    end
  end

  def create
    @trainer = Trainer.new(params[:trainer])
    if current_user.is_gym?
      existing_trainer = Trainer.find_by_email(@trainer.email)
      unless existing_trainer.blank?
        existing_trainer.gym = current_user.gym
        @trainer = existing_trainer
      end
    end
    if @trainer.save
      redirect_to @trainer, :notice => "Successfully created trainer."
    else
      render :action => 'new'
    end
  end

  def edit
    login_required
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

  def remove
    login_required
    @trainer = Trainer.find(params[:id])
    @trainer.gym_id = nil
    if @trainer.save
      redirect_to '/#trainers_tab', :notice  => "Successfully updated trainer."
    else
      render :action => 'show'
    end
  end

  def destroy
    login_required
    @trainer = Trainer.find(params[:id])
    @trainer.destroy
    redirect_to trainers_url, :notice => "Successfully destroyed trainer."
  end
end
