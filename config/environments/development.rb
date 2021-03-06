TrainingTracker::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
#  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_deliveries = true #try to force sending in development
  config.action_mailer.raise_delivery_errors = true

#  ActionMailer::Base.smtp_settings = {
#  :address => 'smtp.gmail.com',
#  :port => 587,
#  :domain => 'sennperformance.com',
#  :authentication => :plain,
#  :user_name => 'info@sennperformance.com',
#  :password => 'cootykola',
#  :enable_starttls_auto => true
#}

  ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'profitnesssuccess.com',
  :authentication => :plain,
  :user_name => 'info@profitnesssuccess.com',
  :password => 'Tracker2012',
  :enable_starttls_auto => true
}

#  Include this line so that can send from other email addresses, instead of just default email host (info@profitnesssuccess.com)
  ActionMailer::Base.delivery_method = :sendmail


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

#  HOST_FOR_URL = "localhost:3000"
  HOST_FOR_URL = "68.185.20.83:3003"
end

