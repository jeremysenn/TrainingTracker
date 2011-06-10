class ImageController < ApplicationController

#  layout 'provider'

  def show
    @image = Image.find(params[:id])
    size = params[:size].nil? ? :default : params[:size]
    render :action => size
  end

  def edit
    @image = Image.find(params[:id])
#    authorize! :edit, @image
  end

  def update
    @image = Image.find(params[:id])
#    authorize! :edit, @image
    if @image.update_attributes(params[:image])
      flash[:notice] = 'Image updated'
      #redirect_to practice_path(@image.album.imageable.practice)
      redirect_to photo_album_biosignature_path(@image.album.imageable)
    else
      render :action => 'edit'
    end
  end
  
  def default
    #begin
      respond_to do |format|
        format.jpg   # show.jpg.flexi 
        format.html # show.html.erb
        format.xml  { render :xml => @image }
      end
    #rescue
    #  logger.error("*** Could not show image #{params[:id]}")
    #end    
  end
  
  def medium
    @image = Image.find(params[:id])
    @size = params[:size].nil? ? '180x220' : params[:size]
    respond_to do |format|
      format.jpg   # show.jpg.flexi 
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end
end
