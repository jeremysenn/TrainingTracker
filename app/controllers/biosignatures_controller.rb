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
  end

  def create
    @client = Client.find(params[:biosignature][:client_id])
    @biosignature = Biosignature.new(params[:biosignature])
    if @client.user == current_user and @biosignature.save
      #redirect_to @biosignature, :notice => "Successfully created biosignature."
      redirect_to client_path(@biosignature.client), :notice  => "Successfully created biosignature."
    else
      render :action => 'new', :notice  => "Error creating biosignature."
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
