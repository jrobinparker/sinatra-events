class UsersController < ApplicationController

  get '/' do
    @user = User.find_by_id(params[:id])
    erb :'users/index'
  end

  get "/signup" do
      erb :'users/signup'
  end

  post "/" do
      @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
      @user.save
      redirect to "/events"
  end

  get "/login" do
      erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "events"
    else
      redirect to "users/failure"
    end
  end

  get "/failure" do
    erb :'home/failure'
  end

  get "/logout" do
    session.clear
    redirect "users/login"
  end

end
