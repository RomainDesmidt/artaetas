class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  cloudinary_transformation :transformation => { :quality => "auto:good" }
  
  def size_range
    0.kilobytes..750.kilobytes
  end
  
  
  def content_type_whitelist
    /image\//
  end
  
  # def exif
  #   # puts self.url
  #   # puts self.filename
  #   httpsimagepath = self.url.insert(4, 's')
  #   # httpsimagepath.slice! self.filename
  #   filename = self.url.split('/').last
  #   httpsimagepath.slice! filename
  #   httpsimagepath = httpsimagepath + 'a_exif/' + filename
  #   return httpsimagepath
  # end
  
   def low
     unless self.url.nil?
      httpsimagepath = self.url.insert(4, 's')
      # httpsimagepath.slice! self.filename
      filename = self.url.split('/').last
      if filename.last(4) == ".jpg"
        filename_noext = filename.split('.').first
      else
        filename_noext = filename
      end
      version = self.url.split('/').last(2).first
      httpsimagepath.slice! filename
      if version.match('[v]\d*').to_s == version
        httpsimagepath.slice! version + '/'
        httpsimagepath = httpsimagepath + 'q_auto:low/' + version + '/' + filename_noext
      else
        httpsimagepath = httpsimagepath + 'q_auto:low/' + filename_noext
      end
      return httpsimagepath
    end
   end
   
    def exifignore
      unless self.url.nil?
        httpsimagepath = self.url.insert(4, 's')
        # httpsimagepath.slice! self.filename
        filename = self.url.split('/').last
        if filename.last(4) == ".jpg"
          filename_noext = filename.split('.').first
        else
          filename_noext = filename
        end
        version = self.url.split('/').last(2).first
        httpsimagepath.slice! filename
        if version.match('[v]\d*').to_s == version
          httpsimagepath.slice! version + '/'
          httpsimagepath = httpsimagepath + 'a_ignore/' + version + '/' + filename_noext
        else
          httpsimagepath = httpsimagepath + 'a_ignore/' + filename_noext
        end
        return httpsimagepath
      end 
   end
   
   
  
  def extension_whitelist
    %w(jpg jpeg)
  end
  
end
