class Users::PasswordsController < Devise::PasswordsController
  def create
    if verify_recaptcha 
      super
    else
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render action: "new"
    end
  end
end