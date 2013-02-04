Engage.configure do |config|
  config.layout = 'application'
  config.user_model = 'User'
  config.mailer_sender = 'engage@knowledgethief.com'
  config.internal_authentication = false
  config.current_user_method = Proc.new { current_user }
  config.login_link = { :path => :new_user_session_path, :opts => {:remote => true} }
  config.username_method = Proc.new { email }
  config.email_method = Proc.new { email  }
end
