class String
#   def low
# #   httpsimagepath = self.insert(4, 's')
#   httpsimagepath = self
#   filename = self.split('/').last
#   httpsimagepath.slice! filename
#   httpsimagepath = httpsimagepath + 'q_auto:low/' + filename
#   return httpsimagepath
#   end
  
#   def exif
# #   httpsimagepath = self.insert(4, 's')
#   httpsimagepath = self
#   filename = self.split('/').last
#   httpsimagepath.slice! filename
#   httpsimagepath = httpsimagepath + 'a_exif/' + filename
#   return httpsimagepath
#   end
  
  def exifignore
   httpsimagepath = self
   filename = self.split('/').last
   if filename.last(4) == ".jpg"
    filename_noext = filename.split('.').first
   else
    filename_noext = filename
   end
   version = self.split('/').last(2).first
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