class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  def content_type_whitelist
    /image\//
  end
end
