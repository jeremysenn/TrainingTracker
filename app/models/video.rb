class Video < ActiveRecord::Base
  attr_accessible :name, :embed_code, :owner_id, :client_id, :url, :owner_type

  belongs_to :owner, :polymorphic => true
  belongs_to :client
  
  def viewable?
    self.video_info && self.video_info.valid?
  end
  
  def video_info
    begin
      VideoInfo.new(CGI.escape(self.url))
    rescue
      nil
    end
  end
  
end
