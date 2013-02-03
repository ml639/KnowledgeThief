Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FAPP_ID, FAPP_SECRET,
           #:scope => 'email,user_birthday,read_stream,read_friendlists,read_insights,user_about_me',
           {:scope => 'email,user_birthday,read_stream,read_friendlists,read_insights,user_about_me,user_interests,user_education_history,user_location', :client_options => {:ssl => {:verify => false}}}
  #provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, {:client_options => {:ssl => {:verify => false}}}
  OmniAuth.config.on_failure = AuthenticationsController.action(:failure)
end

#OmniAuth.config.on_failure = UsersController.action(:oauth_failure)
#OmniAuth.config.on_failure = Proc.new { |env|
#  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
#}

#OmniAuth.config.on_failure = Proc.new do |env| new_path = "/auth/failure"
# [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
#end
