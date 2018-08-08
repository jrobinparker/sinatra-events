require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "events"
  end

  get '/' do
    erb :'home/home'
  end

  get "/signup" do
    if logged_in?
      redirect to "events"
    else
      erb :'home/signup'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:first_name] == "" || params[:last_name] == ""
      redirect 'home/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
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
      erb :'home/login'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "events"
    else
      redirect to "home/failure"
    end
  end

  get "/failure" do
    erb :'home/failure'
  end

  get "/logout" do
    session.clear
    redirect "home/login"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end

end
