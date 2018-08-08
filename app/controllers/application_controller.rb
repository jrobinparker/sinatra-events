require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "events"
  end

  get '/' do
    erb :'/welcome'
  end

  get "/registration" do
    if logged_in?
      redirect to "events"
    else
      erb :'registration/signup'
    end
  end

  post "/registration" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      erb :'registration/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "events"
      end
    end
  end

  get "/login" do
    if logged_in?
      redirect to "events"
    else
      erb :'sessions/login'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     redirect to "/events"
    else
     redirect to "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "login"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end

end
