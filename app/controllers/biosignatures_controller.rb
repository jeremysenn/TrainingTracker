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
      @biosignature.sex = @client.biosignatures.sort_by(&:date).last.sex
      @biosignature.age = @client.biosignatures.sort_by(&:date).last.age
      @biosignature.height = @client.biosignatures.sort_by(&:date).last.height
      @biosignature.height_units = @client.biosignatures.sort_by(&:date).last.height_units
      @biosignature.weight = @client.biosignatures.sort_by(&:date).last.weight
      @biosignature.weight_units = @client.biosignatures.sort_by(&:date).last.weight_units
      @biosignature.chin = @client.biosignatures.sort_by(&:date).last.chin
      @biosignature.cheek = @client.biosignatures.sort_by(&:date).last.cheek
      @biosignature.pec = @client.biosignatures.sort_by(&:date).last.pec
      @biosignature.tri = @client.biosignatures.sort_by(&:date).last.tri
      @biosignature.subscap = @client.biosignatures.sort_by(&:date).last.subscap
      @biosignature.suprailiac = @client.biosignatures.sort_by(&:date).last.suprailiac
      @biosignature.midaxil = @client.biosignatures.sort_by(&:date).last.midaxil
      @biosignature.umbilical = @client.biosignatures.sort_by(&:date).last.umbilical
      @biosignature.knee = @client.biosignatures.sort_by(&:date).last.knee
      @biosignature.calf = @client.biosignatures.sort_by(&:date).last.calf
      @biosignature.quad = @client.biosignatures.sort_by(&:date).last.quad
      @biosignature.ham = @client.biosignatures.sort_by(&:date).last.ham
      @biosignature.waist = @client.biosignatures.sort_by(&:date).last.waist
      @biosignature.hip = @client.biosignatures.sort_by(&:date).last.hip
      @biosignature.neck = @client.biosignatures.sort_by(&:date).last.neck
      @biosignature.shoulder = @client.biosignatures.sort_by(&:date).last.shoulder
      @biosignature.chest = @client.biosignatures.sort_by(&:date).last.chest
      @biosignature.arm = @client.biosignatures.sort_by(&:date).last.arm
      @biosignature.thigh = @client.biosignatures.sort_by(&:date).last.thigh
      @biosignature.gastroc = @client.biosignatures.sort_by(&:date).last.gastroc

    end
  end

  def create
    @client = Client.find(params[:biosignature][:client_id])
    @biosignature = Biosignature.new(params[:biosignature])
    if @client.user == current_user and @biosignature.save
      #redirect_to @biosignature, :notice => "Successfully created biosignature."

      ### SEND EMAIL IF MY CLIENT AND THIS IS THEIR FIRST BIOSIG ###
      if @client.user.username == "jeremysenn" and @client.biosignatures.count == 1
        SupportMailer.new_biosignature_notification(@client).deliver
      end
      
      redirect_to client_path(@biosignature.client) + "#clientbodycomps_tab", :notice  => "Successfully created biosignature."
    elsif @client.user != current_user
      redirect_to '/', :notice  => "Error creating BodyComp - No Access"
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
    @client = @biosignature.client
    if @biosignature.update_attributes(params[:biosignature])
      #redirect_to @biosignature, :notice  => "Successfully updated biosignature."
      redirect_to client_path(@biosignature.client) + "#clientbodycomps_tab", :notice  => "Successfully updated BodyComp."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @biosignature = Biosignature.find(params[:id])
    @biosignature.destroy
    redirect_to biosignatures_url, :notice => "Successfully destroyed BodyComp."
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
