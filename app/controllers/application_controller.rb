class ApplicationController < ActionController::Base
  protect_from_forgery


    def ckeditor_filebrowser_scope(options = {})
      super({ :assetable_id => current_user.id, :assetable_type => 'User' ,:event_id => session[:event_id]}.merge(options))
    end
end
