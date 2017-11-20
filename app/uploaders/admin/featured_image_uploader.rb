class Admin::FeaturedImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
