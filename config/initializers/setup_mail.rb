ActionMailer::Base.smtp_settings = {
  :address              => "smtpout.secureserver.net",
  :port                 => 25,
  :domain               => "event-circle.com",
  :user_name            => "mailer@event-circle.com",
  :password             => "CircleMailer1",
  :authentication       => "plain",
  :enable_starttls_auto => false,  
  :openssl_verify_mode => "none"
}

ActionMailer::Base.raise_delivery_errors = true

