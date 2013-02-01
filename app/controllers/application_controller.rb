class ApplicationController < ActionController::Base
 include Engage::Extensions::Helpers
  protect_from_forgery
  
end
