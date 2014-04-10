class Users::DashBoardController < Devise::SessionsController
	
	before_filter :authenticate_user!, except:[:create]
	def create
		if !params[:role].blank?
		  resource = warden.authenticate!(auth_options)
			if resource.has_role? params[:role]
			  session[:role] = params[:role]
			  super
			else
			  sign_out(resource_name)
			  redirect_to new_user_session_path,notice: "You are not authorized for this role" 
			end    
		  else		     
			redirect_to new_user_session_path,notice: " Please Select your Role" 
		  end
	end
# host methods
	def events_hosted
	  respond_to do |format|
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def host_current_events
	  respond_to do |format|
        format.html # index.html.erb
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def saved_events
	  respond_to do |format|
        format.html # index.html.erb
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def upcoming_events
	  respond_to do |format|
        format.html # index.html.erb
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
#guest methods
	def current_events
	  respond_to do |format|
        format.html # index.html.erb
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def events_attended
	  respond_to do |format|   
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def events_registered
	  respond_to do |format|   
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end

	def become_host
		@user=current_user
		@user.add_role :host
		if @user.save
			redirect_to root_path, :notice => "You become a host Successfully"
		else
			redirect_to root_path, :alert => "Problem in become a host please try later"
		end
	end
	def become_guest
		@user=current_user
		@user.add_role :guest
		if @user.save
			redirect_to root_path, :notice => "You become a Guest Successfully"
		else
			redirect_to root_path, :alert => "Problem in become a Guest please try later"
		end
	end

    def user_contact

    end

    def about_us_dashbord

    end

    def  host_dashboard
    	session[:role]= "host"
    	redirect_to root_path, notice: "you Successfully changed to host dashboard"
    end
    def  guest_dashboard
    	session[:role]= "guest"
    	redirect_to root_path, notice: "you Successfully changed to guest dashboard"
    end
	
	def find_events
	  @events = Event.search(params[:search]).paginate(:per_page => 5, :page => params[:page]) if params[:search]
	end	
end
