class BodycompsController < ApplicationController
  load_and_authorize_resource

  def index
#    @bodycomps = Bodycomp.all
    unless params[:client]
      @bodycomps = []
    else
      @bodycomps = Client.find(params[:client]).bodycomps.sort_by(&:date).reverse
    end
  end

  def show
    @bodycomp = Bodycomp.find(params[:id])
  end

  def new
    @client = Client.find(params[:client])
    @bodycomp = Bodycomp.new(:client_id => @client.id, :date => Date.today)
    ### AUTOFILL WITH LAST BIOSIG NUMBERS ###
    unless @client.bodycomps.blank?
      @bodycomp.sex = @client.bodycomps.sort_by(&:date).last.sex
      @bodycomp.age = @client.bodycomps.sort_by(&:date).last.age
      @bodycomp.height = @client.bodycomps.sort_by(&:date).last.height
      @bodycomp.height_units = @client.bodycomps.sort_by(&:date).last.height_units
      @bodycomp.weight = @client.bodycomps.sort_by(&:date).last.weight
      @bodycomp.weight_units = @client.bodycomps.sort_by(&:date).last.weight_units
      @bodycomp.chin = @client.bodycomps.sort_by(&:date).last.chin
      @bodycomp.cheek = @client.bodycomps.sort_by(&:date).last.cheek
      @bodycomp.pec = @client.bodycomps.sort_by(&:date).last.pec
      @bodycomp.tri = @client.bodycomps.sort_by(&:date).last.tri
      @bodycomp.subscap = @client.bodycomps.sort_by(&:date).last.subscap
      @bodycomp.suprailiac = @client.bodycomps.sort_by(&:date).last.suprailiac
      @bodycomp.midaxil = @client.bodycomps.sort_by(&:date).last.midaxil
      @bodycomp.umbilical = @client.bodycomps.sort_by(&:date).last.umbilical
      @bodycomp.knee = @client.bodycomps.sort_by(&:date).last.knee
      @bodycomp.calf = @client.bodycomps.sort_by(&:date).last.calf
      @bodycomp.quad = @client.bodycomps.sort_by(&:date).last.quad
      @bodycomp.ham = @client.bodycomps.sort_by(&:date).last.ham
      @bodycomp.waist = @client.bodycomps.sort_by(&:date).last.waist
      @bodycomp.hip = @client.bodycomps.sort_by(&:date).last.hip
      @bodycomp.neck = @client.bodycomps.sort_by(&:date).last.neck
      @bodycomp.shoulder = @client.bodycomps.sort_by(&:date).last.shoulder
      @bodycomp.chest = @client.bodycomps.sort_by(&:date).last.chest
      @bodycomp.arm = @client.bodycomps.sort_by(&:date).last.arm
      @bodycomp.thigh = @client.bodycomps.sort_by(&:date).last.thigh
      @bodycomp.gastroc = @client.bodycomps.sort_by(&:date).last.gastroc

    end
  end

  def create
    @client = Client.find(params[:bodycomp][:client_id])
    @bodycomp = Bodycomp.new(params[:bodycomp])
    if @client.trainer == current_user.trainer and @bodycomp.save
      #redirect_to @bodycomp, :notice => "Successfully created bodycomp."

      ### SEND EMAIL IF MY CLIENT AND THIS IS THEIR FIRST BIOSIG ###
#      if @client.user.username == "jeremysenn" and @client.bodycomps.count == 1
#        SupportMailer.new_bodycomp_notification(@client).deliver
#      end

      unless mobile_device?
        redirect_to client_path(@bodycomp.client) + "#clientbodycomps_tab", :notice  => "Successfully created bodycomp."
      else
        redirect_to bodycomp_path(@bodycomp)
      end
      
    elsif @client.trainer != current_user.trainer
      redirect_to '/', :notice  => "Error creating BodyComp - No Access"
    else
      render :action => 'new'
    end
  end

  def edit
    @bodycomp = Bodycomp.find(params[:id])
    @client = @bodycomp.client
  end

  def update
    @bodycomp = Bodycomp.find(params[:id])
    @client = @bodycomp.client
    if @bodycomp.update_attributes(params[:bodycomp])
      #redirect_to @bodycomp, :notice  => "Successfully updated bodycomp."
      redirect_to client_path(@bodycomp.client) + "#clientbodycomps_tab", :notice  => "Successfully updated BodyComp."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomp.destroy
    redirect_to bodycomps_url, :notice => "Successfully destroyed BodyComp."
  end

  def photo_album
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomp.create_album(:name => @bodycomp.created_at) if @bodycomp.album.nil?
  end

  def upload_photo
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomp.album = Album.create(:name => @bodycomp.created_at) if @bodycomp.album.nil?

    if @bodycomp.album.images.create(params[:image])
      flash[:notice] = "Image created"
    else
      flash[:notice] = 'Your image did not pass validation!'
    end
    redirect_to photo_album_bodycomp_path(@bodycomp)
  end

  def delete_image
    @image = Image.find(params[:image_id])
    @bodycomp = @image.album.imageable
    @image.destroy
    redirect_to photo_album_bodycomp_path(@bodycomp)
#    redirect_to photo_album_practice_provider_offer_path(@offer.provider.practice, @offer.provider, @offer)
  end
end
