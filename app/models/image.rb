class Image < ActiveRecord::Base

  attr_accessible :album_id, :image_file, :image_file_data, :caption

  belongs_to :album

  acts_as_fleximage #:image_directory => 'public/images/uploaded'

#  acts_as_fleximage do
#    image_directory 'public/images/uploaded'
#    case Rails.env
#    when 'development'
#      s3_bucket 'faircare-dev-image-uploads'
#    when 'staging'
#      s3_bucket 'faircare-prod-image-uploads'
#    when 'production'
#      s3_bucket 'faircare-prod-image-uploads'
#    else
#      # s3_bucket 'faircare-dev-image-uploads'
#    end
#  end
  
end
