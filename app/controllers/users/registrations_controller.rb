# app/controllers/registrations_controller.rb
require 'open-uri'
class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @address = Address.new
    super
  end

  def create
    if verify_recaptcha()
      build_resource(sign_up_params)
      @address = Address.new(params[:address])
      respond_to do |format|
        if resource.save
          resource.add_role params[:role][:role_id]
          @address.user = resource
          @address.save
          UserMailer.admin_user_pending_mail(resource).deliver if params[:role][:role_id]=="host"
          #UserMailer.confirm_account_activation(@user).deliver
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else   
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render action: "new"
    end  
  end

end 