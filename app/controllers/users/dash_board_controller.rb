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

	def events_attended
	  respond_to do |format|   
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def events_hosted
	  respond_to do |format|
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def current_host_events
	  respond_to do |format|
        format.html # index.html.erb
        format.json { render json: ::EventsDatatable.new(view_context, current_user) }
      end
	end
	def current_events
	  respond_to do |format|
        format.html # index.html.erb
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

    def the_ec
    end
	
end
