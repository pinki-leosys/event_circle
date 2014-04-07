class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => :index
 
  def index
    @role = session[:role]
    if (@role == "guest")
  	  @events_attended = current_user.registered_events.where("event_start_date < ?", Time.now).limit(3)
  	  @current_events = Event.where("event_start_date > ? AND published = ?", Time.now, true).limit(3)
      @events_registered = current_user.registered_events.where("event_start_date >= ?", Time.now).limit(3)
    else
      @events_hosted = current_user.events.where("published = ?", true).limit(3)
      @host_current_events = current_user.events.where("event_start_date < ? AND published = ?", Time.now,true).limit(3)
      @upcoming_events = current_user.events.where("event_start_date > ? AND published = ?", Time.now,true).limit(3)
      @saved_events = current_user.events.where(published: false).limit(3)
    end

  end
  
  def about
  end

  def contact
  end

  def events
  end

  def host_event
  end

  def attend_event
  end

  def sponsor_event
  end

end
