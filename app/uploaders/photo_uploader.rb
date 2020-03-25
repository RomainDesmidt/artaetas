class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  
  def content_type_whitelist
    /image\//
  end
  
  def exif
    # puts self.url
    # puts self.filename
    httpsimagepath = self.url.insert(4, 's')
    # httpsimagepath.slice! self.filename
    filename = self.url.split('/').last
    httpsimagepath.slice! filename
    httpsimagepath = httpsimagepath + 'a_exif/' + filename
    return httpsimagepath
  end
  
   def low
     unless self.nil?
      httpsimagepath = self.url.insert(4, 's')
      # httpsimagepath.slice! self.filename
      filename = self.url.split('/').last
      version = self.url.split('/').last(2).first
      httpsimagepath.slice! filename
      if version.match('[v]\d*').to_s == version
        httpsimagepath.slice! version + '/'
        httpsimagepath = httpsimagepath + 'q_auto:low/' + version + '/' + filename
      else
        httpsimagepath = httpsimagepath + 'q_auto:low/' + filename
      end
      return httpsimagepath
    end
   end
   
    def exifignore
      unless self.nil?
        httpsimagepath = self.url.insert(4, 's')
        # httpsimagepath.slice! self.filename
        filename = self.url.split('/').last
        version = self.url.split('/').last(2).first
        httpsimagepath.slice! filename
        if version.match('[v]\d*').to_s == version
          httpsimagepath.slice! version + '/'
          httpsimagepath = httpsimagepath + 'a_ignore/' + version + '/' + filename
        else
          httpsimagepath = httpsimagepath + 'a_ignore/' + filename
        end
        return httpsimagepath
      end 
   end
   
   
  
  def extension_whitelist
    %w(jpg jpeg)
  end
  
end
