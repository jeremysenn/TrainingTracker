class FoodlogsController < ApplicationController
  #load_and_authorize_resource

  def index
    login_required
    #@foodlogs = Foodlog.all
    @foodlogs = current_user.exercises.all.sort_by(&:name).paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    login_required
    @foodlog = Foodlog.find(params[:id])
    @client = Client.find(params[:client]) unless params[:client].blank?
  end
  
  def new
    login_required
    @foodlog = Foodlog.new
    @client = Client.find(params[:client]) #unless params[:client].blank?
    @foodlog.client = @client
  end
  
  def create
    @foodlog = Foodlog.new(params[:foodlog])
    if @foodlog.save
      flash[:notice] = "Successfully created foodlog."
#      redirect_to @foodlog
        redirect_to "/#myfoodlog_tab"
    else
      render :action => 'new'
    end
  end
  
  def edit
    login_required
    @foodlog = Foodlog.find(params[:id])
  end
  
  def update
    @foodlog = Foodlog.find(params[:id])
    if @foodlog.update_attributes(params[:foodlog])
      flash[:notice] = "Successfully updated foodlog."
      redirect_to "/#myfoodlog_tab"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @foodlog = Foodlog.find(params[:id])
    @foodlog.destroy
    flash[:notice] = "Successfully destroyed exercise."
    redirect_to exercises_url
  end
end
