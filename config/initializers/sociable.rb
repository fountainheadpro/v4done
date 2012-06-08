require 'sociable/profile/omniauth_callbacks_controller'

Devise.setup do |config|

  config.omniauth :twitter, "gm83R4XtU3ah02e8bjYbw", "LW5DnpLhqTvfeCzYHxlryQ7eR8URmqJMWKkknhjM",
  {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}


end