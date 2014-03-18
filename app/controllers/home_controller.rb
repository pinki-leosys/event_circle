class HomeController < ApplicationController
	before_filter :authenticate_user!, :only => :index
 
  def index
    @role = session[:role]
  	@events_attended = current_user.registered_events     
  	@events_published = Event.where(published: true)
    @users = User.all
      if @role =="host"
  	    @events_for_publish = current_user.events.where(published: false)
        @events_published_by_you = current_user.events.where(published: true)
      end
  end
  
  def about
  end

  def activate_user   
    @user = User.find(params[:id])
    if @user.update_attribute(:is_active, true)
      UserMailer.admin_account_confirmation(@user).deliver
      redirect_to root_url,  :notice=> 'User activated successfully.'
    else
     render "index"
    end 
  end

end
