class UserMailer < ActionMailer::Base
  default to: Proc.new { User.pluck(:email) },
          from: 'mailer@event-circle.com'

  def event_invitation(user)
    @user = user
    mail(:subject => "Invite for an Event")
  end

  def confirm_account_activation(user)
    @url  = "http://0.0.0.0:3000/users/#{user.confirmation_token}/activate"
    @user = user
    mail(:to => user.email, :subject => 'Welcome to eventcircle')
  end 

  def admin_account_confirmation(user)
    @user = user
    @url  = "http://0.0.0.0:3000/"    
    mail(:to => user.email, :subject => 'Your account is activated by Admin.')
  end 

  def admin_user_pending_mail(user)
    @user = user
    mail(:to => 'mailer@event-circle.com', :subject => 'A new user was signed up!!111')
  end

  def new_user(user)
    @user = user
    mail(:to => user.email, :subject => 'A new user has signed up!!111')
  end

  def admin_contact_mail(user)
    @user = user
    mail(:to => 'mailer@event-circle.com', :subject => 'Contact form from user')
  end
end