class BiosignaturesController < ApplicationController
  def index
    @biosignatures = Biosignature.all
  end

  def show
    @biosignature = Biosignature.find(params[:id])
  end

  def new
    @client = Client.find(params[:client])
    @biosignature = Biosignature.new(:client_id => @client.id, :date => Date.today)
  end

  def create
    @biosignature = Biosignature.new(params[:biosignature])
    if @biosignature.save
      #redirect_to @biosignature, :notice => "Successfully created biosignature."
      redirect_to client_path(@biosignature.client), :notice  => "Successfully created biosignature."
    else
      render :action => 'new'
    end
  end

  def edit
    @biosignature = Biosignature.find(params[:id])
    @client = @biosignature.client
  end

  def update
    @biosignature = Biosignature.find(params[:id])
    if @biosignature.update_attributes(params[:biosignature])
      #redirect_to @biosignature, :notice  => "Successfully updated biosignature."
      redirect_to client_path(@biosignature.client), :notice  => "Successfully updated biosignature."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @biosignature = Biosignature.find(params[:id])
    @biosignature.destroy
    redirect_to biosignatures_url, :notice => "Successfully destroyed biosignature."
  end
end
