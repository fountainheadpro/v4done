require "sociable/controllers/omniauth_callbacks_controller"

Sociable.setup  do |config|

  config.twitter "gm83R4XtU3ah02e8bjYbw", "LW5DnpLhqTvfeCzYHxlryQ7eR8URmqJMWKkknhjM",
    {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}

  config.facebook "143600179043862", "eaea410a1d758235d73c0c18797e8bcb",
    {:scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}

  #config.linkedin "1jw6uriv8y1n", "Qh7WQCxT1zkI853Z",
  #  {:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}



end

#Devise.setup  do |config|

#  config.omniauth :twitter, "gm83R4XtU3ah02e8bjYbw", "LW5DnpLhqTvfeCzYHxlryQ7eR8URmqJMWKkknhjM",
#    {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}

#  config.omniauth :facebook, "143600179043862", "eaea410a1d758235d73c0c18797e8bcb",
#    {:scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}

#end