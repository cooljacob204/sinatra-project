require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'
require 'require_all'

require_all 'app/models'
require_all 'app/middlewares'
set :database_file, 'db/config.yml'


class MyApp < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    set :session_secret, 'password_security'
    enable :sessions
  end

  def authenticate(session)
    user = User.find_by(:email => session[:email])
    return user if user && user.session_id == session[:session_id]
    false
  end
end