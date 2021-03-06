class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => :index
 
  def index
    @role = session[:role]
    if (@role == "guest")
      @events_attended = current_user.registered_events.where("event_start_date < ? AND event_end_date < ?", Time.zone.now,Time.zone.now).limit(3).order("event_start_date")
      @current_events = Event.where("event_start_date <= ? AND event_end_date > ? AND published = ?", Time.zone.now,Time.zone.now, true).limit(3).order("event_start_date")
      @events_registered = current_user.registered_events.where("event_start_date > ?", Time.zone.now).limit(3).order("event_start_date")
    else
      @events_hosted = current_user.events.where("event_end_date < ? AND event_start_date < ? AND published = ?", Time.zone.now,Time.zone.now, true).limit(3).order("event_start_date")
      @host_current_events = current_user.events.where("event_start_date <= ? AND event_end_date > ? AND published = ?",  Time.zone.now,Time.zone.now,true).limit(3).order("event_start_date")
      @upcoming_events = current_user.events.where("event_start_date > ? AND published = ?", Time.zone.now,true).limit(3).order("event_start_date")
      @saved_events = current_user.events.where(published: false).limit(3).order("event_start_date")
    end

  end
  
  def about
  end

  def new
  end

  def contact_us_message
  end

  def create
    if params[:contact1]
      if verify_recaptcha()
      @contact = params[:contact1]
        if params[:contact1]
          UserMailer.admin_contact_mail(@contact).deliver
          flash.now[:alert] = 'Thank you for your message. We will contact you soon!'
          redirect_to contact_us_message_path
        else
          flash[:error] = 'Cannot send message.'
          render :new
        end

    else
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        flash.delete :recaptcha_error
        render action: "new"
      end
    else
      render "new"
    end 
  end

  def user_events
    @events = Event.where("published = ? AND event_start_date >= ?", true, Time.zone.now).paginate(:page => params[:page], :per_page => 8)
    respond_to do |format|
      format.html 
    end
  end

  def host_event
    @role = params[:role]
    redirect_to sign_up_path(:role=>"host")
  end

  def attend_event
    redirect_to sign_up_path(:role=>"guest")
  end

  def sponsor_event
  end

  def read_more
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end  

  def search
    @events = Event.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end  

end