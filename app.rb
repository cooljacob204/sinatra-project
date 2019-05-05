require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'
require 'require_all'

require_all 'app/models'
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
    set_session(User.null_user)
    User.null_user
  end

  def set_session(user)
    session[:firstname] = user.firstname
    session[:lastname] = user.lastname
    session[:email] = user.email
    session[:role] = user.role
  end
end