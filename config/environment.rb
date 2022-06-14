# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => "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",
  :domain => 'fabgrel10@gmail.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
