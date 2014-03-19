ActionMailer::Base.smtp_settings = {
  :address              => "smtp.1and1.com",
  :port                 => 25,
  :domain               => "1and1.com",
  :user_name            => "jayashrit@leotechnosoft.net",
  :password             => "jayashri@6534",
  :authentication       => "plain",
  :enable_starttls_auto => false,  
  :openssl_verify_mode => "none"
}

ActionMailer::Base.raise_delivery_errors = true
