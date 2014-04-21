
require 'streamio-ffmpeg'
module ControllerVideoProcessor
   def thumbnail path, second, id,file_name
     movie = FFMPEG::Movie.new("#{Rails.root}/public"+path)
     return movie.screenshot("#{Rails.root}/public/uploads/ckeditor/attachments/#{id}/#{File.basename(file_name ,'.*')}.jpg", {:seek_time => second,resolution: '200x120'})
   end
end

