# app/controllers/registrations_controller.rb
require 'bcrypt'
require 'open-uri'
class Users::RegistrationsController < Devise::RegistrationsController
  include BCrypt

  def new    
    @user= User.new
    @address = Address.new
    super
  end

  def create
      @user = User.new(params[:user])
      @address = Address.new(params[:address])
      respond_to do |format|
        if @user.save
          @user.add_role params[:role][:role_id]
          @address.user = @user
          @address.save
          UserMailer.admin_user_pending_mail(@user).deliver if params[:role][:role_id]=="host"
          #UserMailer.confirm_account_activation(@user).deliver
          format.html { redirect_to root_url, notice: 'You are registered successfully. Please check your email to login.' }
          format.json { head :no_content }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

end 