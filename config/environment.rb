# Load the rails application
require File.expand_path('../application', __FILE__)

KnowledgeThief::Application.configure do
   config.assets.compile = true
end
# Initialize the rails application
Kt::Application.initialize!
