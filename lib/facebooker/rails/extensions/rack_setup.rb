# require 'rack/facebook'
# ActionController::Dispatcher.middleware.insert_after 'ActionController::RewindableInput',Rack::Facebook, Facebooker.secret_key


# Somewhere in 2.3 RewindableInput was removed- rack supports it natively
require 'rack/facebook'
ActionController::Dispatcher.middleware.insert_before( 
  ActionController::ParamsParser,
  Rack::Facebook
)