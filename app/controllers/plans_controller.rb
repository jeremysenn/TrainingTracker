class PlansController < ApplicationController
  load_and_authorize_resource

  def index
    login_required
    @plans = Plan.all
  end

  def show
    login_required
    @plan = Plan.find(params[:id])
    authorize! :read, @plan
  end

  def new
    login_required
    authorize! :create, Plan
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(params[:plan])
    if @plan.save
      redirect_to @plan, :notice => "Successfully created plan."
    else
      render :action => 'new'
    end
  end

  def edit
    login_required
    @plan = Plan.find(params[:id])
    authorize! :edit, @plan
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated plan."
    else
      render :action => 'edit'
    end
  end

  def destroy
    login_required
    @plan = Plan.find(params[:id])
    authorize! :destroy, @plan
    @plan.destroy
    redirect_to plans_url, :notice => "Successfully destroyed plan."
  end
end
