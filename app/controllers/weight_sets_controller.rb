class WeightSetsController < ApplicationController
  def index
    #@weight_sets = WeightSet.all
    @weight_sets = []
    redirect_to '/'
  end
  
  def show
    @weight_set = WeightSet.find(params[:id])
  end
  
  def new
    @weight_set = WeightSet.new
  end
  
  def create
    @weight_set = WeightSet.new(params[:weight_set])
    if @weight_set.save
      flash[:notice] = "Successfully created weight set."
      redirect_to @weight_set
    else
      render :action => 'new'
    end
  end
  
  def edit
    @weight_set = WeightSet.find(params[:id])
  end
  
  def update
    @weight_set = WeightSet.find(params[:id])
    if @weight_set.update_attributes(params[:weight_set])
      flash[:notice] = "Successfully updated weight set."
      redirect_to @weight_set
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @weight_set = WeightSet.find(params[:id])
    @weight_set.destroy
    flash[:notice] = "Successfully destroyed weight set."
    redirect_to weight_sets_url
  end
end
