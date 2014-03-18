class Users::DashBoardController < Devise::SessionsController
	
	def create
		if !params[:role].blank?
		  resource = warden.authenticate!(auth_options)
			if (resource.has_role? "admin" || "guest" ) || (resource.has_role? "host" && resource.is_active=="true")
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
	
end
