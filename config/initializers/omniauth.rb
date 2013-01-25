Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FAPP_ID, FAPP_SECRET
end
