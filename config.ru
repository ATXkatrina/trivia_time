# config.ru
require 'sinatra/base'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

# map the controllers to routes
# map('/phone') { run PhoneController }
# map('/game') { run GameController }
map('/') { run ApplicationController }


# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

configure do
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

run Sinatra::Application
