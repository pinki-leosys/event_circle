class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => :index
 
  def index
    @role = session[:role]
  	@events_attended = current_user.registered_events.where("event_start_date < ?", Time.now)    
  	@current_events = Event.where("event_start_date > ?", Time.now)
    @events_hosted = current_user.events.where("event_start_date < ?", Time.now)
    @current_host_events = current_user.events.where("event_start_date > ?", Time.now)

  end
  
  def about
  end

end
