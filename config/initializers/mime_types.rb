# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

Mime::Type.register "video/mp4", :mp4
Mime::Type.register "video/flv", :flv
Mime::Type.register "video/avi", :avi
MIME::Types.add(MIME::Type.from_array("video/mp4,video/flv,video/avi,video/MP4,video/3gp", %(mp4,flv,avi,MP4,3gp)))
Rack::Mime::MIME_TYPES.merge!({
".ogg" => "application/ogg",
".ogx" => "application/ogg",
".MP4" => "application/MP4", 
".ogv" => "video/ogg",
".oga" => "audio/ogg",
".flv" => "video/flv",
".avi" => "video/avi",
".MP4" => "video/MP4",
".mp4" => "video/mp4",
".m4v" => "video/mp4",
".mov" => "video/mov",
".3gp" => "video/3gp",
".mp3" => "audio/mpeg",
".m4a" => "audio/mpeg"
})