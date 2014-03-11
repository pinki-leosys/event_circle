class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => :index
 
  def index
    @role = session[:role]
  	@events_attended = current_user.registered_events     
  	@events_published = Event.where(published: true)
      if @role =="host"
  	    @events_for_publish = current_user.events.where(published: false)
        @events_published_by_you = current_user.events.where(published: true)
      end
  end
  
  def about
  end

end
