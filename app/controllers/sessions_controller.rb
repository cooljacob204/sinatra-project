class SessionsController < MyApp
  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    
    if user && user.authenticate(params[:password])
      user.update(:session_id => session[:session_id])
      session[:firstname] = user.firstname
      session[:lastname] = user.lastname
      session[:email] = user.email
      session[:role] = :guest
      redirect "/"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    user = User.find_by(:email => session[:email])
    user.update(:session_id => nil) if user && user.session_id == session[:session_id]
    
    session.clear
    redirect "/"
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    user = User.new(params)

    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end
end