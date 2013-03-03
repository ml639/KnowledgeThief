#OmniAuth.config.logger = Rails.logger

if !Rails.env.production?
	FAPP_ID='415358701886018'
	FAPP_SECRET='399b918b8c7accb967b3a497beb21c40'
else	
	FAPP_ID='355533941222972'
	FAPP_SECRET='96673e69de7c6558cb60a4ed23a1c0f4'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FAPP_ID, FAPP_SECRET,
           #:scope => 'email,user_birthday,read_stream,read_friendlists,read_insights,user_about_me',
           {:scope => 'email,publish_stream,user_birthday,read_stream,read_friendlists,read_insights,user_about_me,user_interests,user_education_history,user_location', :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}} #:client_options => {:ssl => {:verify => false}}}
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
