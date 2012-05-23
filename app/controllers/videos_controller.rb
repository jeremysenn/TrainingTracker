class VideosController < ApplicationController
#  layout 'application'

  def show
    @video = Video.find(params[:id])
    @video_info = VideoInfo.new(@video.url)
    unless mobile_device?
      render :layout => false
    end
  end

  def index
#    @providers = Provider.all.sort_by(&:last_name)
#    @offers = Offer.all.sort_by(&:short_description)
#    @marketing_videos = MarketingVideo.all.sort_by(&:name)
  end

end
