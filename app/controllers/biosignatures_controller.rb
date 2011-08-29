class BiosignaturesController < ApplicationController
  load_and_authorize_resource

  def index
#    @biosignatures = Biosignature.all
    @biosignatures = current_user.biosignatures
  end

  def show
    @biosignature = Biosignature.find(params[:id])
  end

  def new
    @client = Client.find(params[:client])
    @biosignature = Biosignature.new(:client_id => @client.id, :date => Date.today)
    ### AUTOFILL WITH LAST BIOSIG NUMBERS ###
    unless @client.biosignatures.blank?
      @biosignature.sex = @client.biosignatures.last.sex
      @biosignature.age = @client.biosignatures.last.age
      @biosignature.height = @client.biosignatures.last.height
      @biosignature.height_units = @client.biosignatures.last.height_units
      @biosignature.weight = @client.biosignatures.last.weight
      @biosignature.weight_units = @client.biosignatures.last.weight_units
      @biosignature.chin = @client.biosignatures.last.chin
      @biosignature.cheek = @client.biosignatures.last.cheek
      @biosignature.pec = @client.biosignatures.last.pec
      @biosignature.tri = @client.biosignatures.last.tri
      @biosignature.subscap = @client.biosignatures.last.subscap
      @biosignature.suprailiac = @client.biosignatures.last.suprailiac
      @biosignature.midaxil = @client.biosignatures.last.midaxil
      @biosignature.umbilical = @client.biosignatures.last.umbilical
      @biosignature.knee = @client.biosignatures.last.knee
      @biosignature.calf = @client.biosignatures.last.calf
      @biosignature.quad = @client.biosignatures.last.quad
      @biosignature.ham = @client.biosignatures.last.ham
      @biosignature.waist = @client.biosignatures.last.waist
      @biosignature.hip = @client.biosignatures.last.hip

    end
  end

  def create
    @client = Client.find(params[:biosignature][:client_id])
    @biosignature = Biosignature.new(params[:biosignature])
    if @client.user == current_user and @biosignature.save
      #redirect_to @biosignature, :notice => "Successfully created biosignature."
      redirect_to client_path(@biosignature.client), :notice  => "Successfully created biosignature."
    elsif @client.user != current_user
      redirect_to '/', :notice  => "Error creating biosignature - No Access"
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

  def photo_album
    @biosignature = Biosignature.find(params[:id])
    @biosignature.create_album(:name => @biosignature.created_at) if @biosignature.album.nil?
  end

  def upload_photo
    @biosignature = Biosignature.find(params[:id])
    @biosignature.album = Album.create(:name => @biosignature.created_at) if @biosignature.album.nil?

    if @biosignature.album.images.create(params[:image])
      flash[:notice] = "Image created"
    else
      flash[:notice] = 'Your image did not pass validation!'
    end
    redirect_to photo_album_biosignature_path(@biosignature)
  end

  def delete_image
    @image = Image.find(params[:image_id])
    @biosignature = @image.album.imageable
    @image.destroy
    redirect_to photo_album_biosignature_path(@biosignature)
#    redirect_to photo_album_practice_provider_offer_path(@offer.provider.practice, @offer.provider, @offer)
  end
end
